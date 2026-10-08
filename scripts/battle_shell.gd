extends Control

signal return_requested

const CANVAS_SIZE := Vector2(640.0, 360.0)
const INITIATIVE_HEIGHT := 36.0
const BATTLEFIELD_HEIGHT := 238.0
const HUD_TOP := 274.0
const HUD_HEIGHT := 86.0
const BAND_WIDTH := 128.0

# Locked combat-bar palette. These are the prototype's only chromatic colors;
# every non-bar element remains grayscale.
const HEALTH_COLOR := Color(0.560784, 0.062745, 0.145098, 1.0) # #8F1025
const ACTION_GAUGE_COLOR := Color(0.0, 0.749020, 0.0, 1.0) # #00BF00
const MANA_COLOR := Color(0.156863, 0.329412, 0.721569, 1.0) # #2854B8
const RAGE_COLOR := Color(1.0, 0.231373, 0.478431, 1.0) # #FF3B7A
const ENERGY_COLOR := Color(1.0, 0.992157, 0.003922, 1.0) # #FFFD01
const WARLOCK_RESOURCE_COLOR := Color(0.568627, 0.247059, 0.815686, 1.0) # #913FD0
const FAITH_COLOR := Color(0.956863, 0.956863, 0.941176, 1.0) # #F4F4F0
const FOCUS_COLOR := Color(0.949020, 0.541176, 0.094118, 1.0) # #F28A18
const WARDEN_RESOURCE_COLOR := Color(0.0, 0.380392, 0.235294, 1.0) # #00613C
const RESOLVE_COLOR := Color(0.721569, 0.450980, 0.2, 1.0) # #B87333

const HUD_BAR_SLOT_COUNT := 5
const HUD_BAR_OFFSET := Vector2(36.0, 22.0)
const HUD_BAR_SIZE := Vector2(158.0, 7.0)
const HUD_BAR_STEP_Y := 9.0
const BAR_TRACK_COLOR := Color(0.08, 0.08, 0.08, 1.0)
const BAR_BORDER_COLOR := Color(0.92, 0.92, 0.92, 1.0)

const ACTOR_HALF_SIZE := Vector2(8.0, 10.0)
const PLAYABLE_RECT := Rect2(10.0, 58.0, 620.0, 196.0)
const ENEMY_CRATE := Rect2(168.0, 94.0, 34.0, 28.0)
const PARTY_CRATE := Rect2(438.0, 202.0, 34.0, 28.0)
const OIL_BARREL := Rect2(270.0, 146.0, 18.0, 28.0)

# Prototype-only tuning values. These prove the common cost pipeline and are
# deliberately isolated for later balancing.
const MAX_ACTION_GAUGE := 100.0
const MOVE_SPEED := 112.0
const MOVE_COST_PER_PIXEL := 0.18
const ZONE_TRANSITION_COST := 12.0
const ENEMY_ACTION_DELAY := 0.72
const BASE_ACCURACY := 95.0
const PARTIAL_COVER_PENALTY := 20.0
const CRATE_MAX_HP := 7
const OIL_SURFACE_RADIUS := 30.0

const BATTLE_ACTIVE := "active"
const BATTLE_VICTORY := "victory"
const BATTLE_DEFEAT := "defeat"

var party: Array[Dictionary] = []
var enemies: Array[Dictionary] = []
var selected_party_index := 0
var current_block_index := 0
var initiative_set := 1

var click_target := Vector2.ZERO
var click_target_active := false
var attack_mode_active := false
var confirm_end_block := false
var enemy_action_timer := 0.0
var enemy_action_queue: Array[int] = []

var environment_objects: Array[Dictionary] = []
var oil_surface_active := false
var battle_state := BATTLE_ACTIVE

var feedback_text := ""
var feedback_timer := 0.0

var end_block_button: Button
var attack_button: Button
var reroll_button: Button
var return_button: Button
var randomizer := RandomNumberGenerator.new()


func _ready() -> void:
	position = Vector2.ZERO
	size = CANVAS_SIZE
	# The battlefield is drawn rather than built from child Controls. Ignoring
	# root mouse input lets unhandled clicks reach selection and movement while
	# the three real Button children continue to receive normal GUI input.
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	randomizer.randomize()
	_build_combatant_data()
	_build_environment_data()
	_generate_deployment()
	_build_buttons()
	_enter_block(0, true)
	queue_redraw()


func _process(delta: float) -> void:
	if feedback_timer > 0.0:
		feedback_timer = maxf(0.0, feedback_timer - delta)

	if battle_state == BATTLE_ACTIVE:
		if _is_party_block():
			if not confirm_end_block:
				_update_selected_movement(delta)
		else:
			_update_enemy_block(delta)

	_update_button_state()
	queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if attack_mode_active:
			_cancel_attack_mode("ATTACK CANCELED")
			get_viewport().set_input_as_handled()
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if _handle_left_click(event.position):
			get_viewport().set_input_as_handled()
		return

	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			get_viewport().set_input_as_handled()
			if attack_mode_active:
				_cancel_attack_mode("ATTACK CANCELED")
			elif confirm_end_block:
				confirm_end_block = false
				_set_feedback("END BLOCK CANCELED")
			else:
				return_requested.emit()
		elif event.keycode == KEY_R:
			get_viewport().set_input_as_handled()
			_reset_battle()
		elif event.keycode == KEY_F and _is_party_block() and battle_state == BATTLE_ACTIVE:
			get_viewport().set_input_as_handled()
			_toggle_attack_mode()
		elif event.keycode == KEY_E and _is_party_block() and battle_state == BATTLE_ACTIVE:
			get_viewport().set_input_as_handled()
			_request_end_block()
		elif event.keycode == KEY_TAB and _is_party_block():
			get_viewport().set_input_as_handled()
			_cycle_active_selection()


func _draw() -> void:
	var ink = Color(0.11, 0.11, 0.11)
	var white = Color(0.95, 0.95, 0.95)
	var font = ThemeDB.fallback_font

	draw_rect(Rect2(Vector2.ZERO, CANVAS_SIZE), Color(0.86, 0.86, 0.86), true)
	_draw_initiative_ribbon(ink, white, font)
	_draw_battlefield(ink, font)
	_draw_environment(ink, font)
	_draw_movement_preview(ink, white, font)
	_draw_attack_targeting(ink, white, font)
	_draw_combatants(ink, font)
	_draw_command_status(ink, font)
	_draw_party_hud(ink, white, font)

	if confirm_end_block:
		_draw_end_block_confirmation(ink, white, font)
	if battle_state != BATTLE_ACTIVE:
		_draw_battle_result(ink, white, font)


func _build_combatant_data() -> void:
	party = [
		{
			"id": "archer",
			"name": "ARCHER",
			"companion": "R",
			"resource": "FOCUS",
			"max_hp": 18,
			"hp": 18,
			"resource_ratio": 1.0,
			"position": Vector2.ZERO,
			"action_gauge": MAX_ACTION_GAUGE,
			"basic_attack_uses": 0,
			"basic_attack_use_modifier": 0,
			"alive": true,
			"dodge": 0.0,
			"attack": {
				"name": "BOW SHOT",
				"range": 205.0,
				"cost": 34.0,
				"damage": 4,
				"accuracy": BASE_ACCURACY,
				"uses_per_turn": 1,
				"ranged": true
			}
		},
		{
			"id": "warrior",
			"name": "WARRIOR",
			"companion": "D",
			"resource": "RESOLVE",
			"max_hp": 26,
			"hp": 26,
			"resource_ratio": 1.0,
			"position": Vector2.ZERO,
			"action_gauge": MAX_ACTION_GAUGE,
			"basic_attack_uses": 0,
			"basic_attack_use_modifier": 0,
			"alive": true,
			"dodge": 0.0,
			"attack": {
				"name": "SWORD STRIKE",
				"range": 24.0,
				"cost": 26.0,
				"damage": 5,
				"accuracy": BASE_ACCURACY,
				"uses_per_turn": 1,
				"ranged": false
			}
		},
		{
			"id": "mage",
			"name": "MAGE",
			"companion": "E",
			"resource": "MANA",
			"max_hp": 20,
			"hp": 20,
			"resource_ratio": 1.0,
			"position": Vector2.ZERO,
			"action_gauge": MAX_ACTION_GAUGE,
			"basic_attack_uses": 0,
			"basic_attack_use_modifier": 0,
			"alive": true,
			"dodge": 0.0,
			"attack": {
				"name": "STAFF STRIKE",
				"range": 26.0,
				"cost": 24.0,
				"damage": 3,
				"accuracy": BASE_ACCURACY,
				"uses_per_turn": 1,
				"ranged": false
			}
		}
	]

	enemies = [
		{
			"id": "sludge_a", "name": "SLUDGE", "max_hp": 9, "hp": 9,
			"position": Vector2.ZERO, "action_gauge": MAX_ACTION_GAUGE,
			"basic_attack_uses": 0, "basic_attack_use_modifier": 0,
			"alive": true, "dodge": 0.0,
			"attack": {"name": "OOZE SLAP", "range": 22.0, "cost": 30.0, "damage": 3, "accuracy": BASE_ACCURACY, "uses_per_turn": 1, "ranged": false}
		},
		{
			"id": "sludge_b", "name": "SLUDGE", "max_hp": 9, "hp": 9,
			"position": Vector2.ZERO, "action_gauge": MAX_ACTION_GAUGE,
			"basic_attack_uses": 0, "basic_attack_use_modifier": 0,
			"alive": true, "dodge": 0.0,
			"attack": {"name": "OOZE SLAP", "range": 22.0, "cost": 30.0, "damage": 3, "accuracy": BASE_ACCURACY, "uses_per_turn": 1, "ranged": false}
		},
		{
			"id": "toad", "name": "TOAD", "max_hp": 13, "hp": 13,
			"position": Vector2.ZERO, "action_gauge": MAX_ACTION_GAUGE,
			"basic_attack_uses": 0, "basic_attack_use_modifier": 0,
			"alive": true, "dodge": 0.0,
			"attack": {"name": "TONGUE STRIKE", "range": 58.0, "cost": 32.0, "damage": 4, "accuracy": BASE_ACCURACY, "uses_per_turn": 1, "ranged": true, "element": "WATER"}
		}
	]


func _build_environment_data() -> void:
	environment_objects = [
		{"id": "enemy_crate", "name": "CRATE", "kind": "crate", "rect": ENEMY_CRATE, "hp": CRATE_MAX_HP, "max_hp": CRATE_MAX_HP, "intact": true},
		{"id": "party_crate", "name": "CRATE", "kind": "crate", "rect": PARTY_CRATE, "hp": CRATE_MAX_HP, "max_hp": CRATE_MAX_HP, "intact": true},
		{"id": "oil_barrel", "name": "OIL BARREL", "kind": "barrel", "rect": OIL_BARREL, "hp": 1, "max_hp": 1, "intact": true}
	]
	oil_surface_active = false


func _build_buttons() -> void:
	attack_button = Button.new()
	attack_button.text = "ATTACK [F]"
	attack_button.position = Vector2(254.0, 6.0)
	attack_button.size = Vector2(88.0, 24.0)
	attack_button.add_theme_font_size_override("font_size", 7)
	_style_button(attack_button)
	attack_button.pressed.connect(_on_attack_pressed)
	add_child(attack_button)

	end_block_button = Button.new()
	end_block_button.text = "END BLOCK [E]"
	end_block_button.position = Vector2(346.0, 6.0)
	end_block_button.size = Vector2(108.0, 24.0)
	end_block_button.add_theme_font_size_override("font_size", 7)
	_style_button(end_block_button)
	end_block_button.pressed.connect(_on_end_block_pressed)
	add_child(end_block_button)

	reroll_button = Button.new()
	reroll_button.text = "RESET [R]"
	reroll_button.position = Vector2(458.0, 6.0)
	reroll_button.size = Vector2(78.0, 24.0)
	reroll_button.add_theme_font_size_override("font_size", 7)
	_style_button(reroll_button)
	reroll_button.pressed.connect(_on_reroll_pressed)
	add_child(reroll_button)

	return_button = Button.new()
	return_button.text = "TOWN [ESC]"
	return_button.position = Vector2(540.0, 6.0)
	return_button.size = Vector2(94.0, 24.0)
	return_button.add_theme_font_size_override("font_size", 7)
	_style_button(return_button)
	return_button.pressed.connect(_on_return_pressed)
	add_child(return_button)


func _update_button_state() -> void:
	var party_turn = battle_state == BATTLE_ACTIVE and _is_party_block() and selected_party_index >= 0
	attack_button.visible = party_turn
	if attack_mode_active:
		attack_button.text = "CANCEL [F]"
	elif party_turn and not _selected_has_basic_attack_use():
		attack_button.text = "ATTACK USED"
	else:
		attack_button.text = "ATTACK [F]"
	attack_button.disabled = not party_turn or (not attack_mode_active and not _selected_can_basic_attack())
	end_block_button.visible = party_turn
	end_block_button.text = "CONFIRM [E]" if confirm_end_block else "END BLOCK [E]"
	reroll_button.text = "RETRY [R]" if battle_state != BATTLE_ACTIVE else "RESET [R]"


func _style_button(button: Button) -> void:
	button.add_theme_color_override("font_color", Color(0.94, 0.94, 0.94))
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_color_override("font_pressed_color", Color.WHITE)
	button.add_theme_color_override("font_disabled_color", Color(0.48, 0.48, 0.48))
	button.add_theme_stylebox_override("normal", _button_style(Color(0.18, 0.18, 0.18), Color(0.62, 0.62, 0.62), 1))
	button.add_theme_stylebox_override("hover", _button_style(Color(0.28, 0.28, 0.28), Color.WHITE, 1))
	button.add_theme_stylebox_override("pressed", _button_style(Color(0.08, 0.08, 0.08), Color.WHITE, 2))
	button.add_theme_stylebox_override("disabled", _button_style(Color(0.12, 0.12, 0.12), Color(0.34, 0.34, 0.34), 1))
	button.add_theme_stylebox_override("focus", _button_style(Color(0.0, 0.0, 0.0, 0.0), Color.WHITE, 1))


func _button_style(background: Color, border: Color, width: int) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = background
	style.border_color = border
	style.border_width_left = width
	style.border_width_top = width
	style.border_width_right = width
	style.border_width_bottom = width
	style.corner_radius_top_left = 0
	style.corner_radius_top_right = 0
	style.corner_radius_bottom_left = 0
	style.corner_radius_bottom_right = 0
	return style


func _on_attack_pressed() -> void:
	_toggle_attack_mode()


func _on_end_block_pressed() -> void:
	_request_end_block()


func _on_reroll_pressed() -> void:
	_reset_battle()


func _on_return_pressed() -> void:
	return_requested.emit()


func _request_end_block() -> void:
	if battle_state != BATTLE_ACTIVE or not _is_party_block():
		return

	click_target_active = false
	attack_mode_active = false
	if confirm_end_block or not _active_block_has_gauge():
		confirm_end_block = false
		_advance_block()
		return

	confirm_end_block = true
	_set_feedback("PRESS E OR END BLOCK AGAIN TO CONFIRM")


func _active_block_has_gauge() -> bool:
	for party_index in _active_party_indices():
		if float(party[party_index]["action_gauge"]) > 0.01:
			return true
	return false


func _advance_block() -> void:
	if battle_state != BATTLE_ACTIVE:
		return
	click_target_active = false
	attack_mode_active = false
	confirm_end_block = false

	for _step in range(4):
		var next_block = current_block_index + 1
		if next_block >= 4:
			next_block = 0
			initiative_set += 1
		current_block_index = next_block
		if _block_has_living_actor(next_block):
			_enter_block(next_block, false)
			return

	_check_battle_result()


func _enter_block(block_index: int, initial_entry: bool) -> void:
	if battle_state != BATTLE_ACTIVE:
		return
	current_block_index = block_index
	click_target_active = false
	attack_mode_active = false
	confirm_end_block = false
	enemy_action_queue.clear()

	if _is_party_block():
		var active_indices = _active_party_indices()
		if active_indices.is_empty():
			_advance_block()
			return
		for party_index in active_indices:
			party[party_index]["action_gauge"] = MAX_ACTION_GAUGE
			party[party_index]["basic_attack_uses"] = 0
		selected_party_index = active_indices[0]
		if not initial_entry:
			_set_feedback("%s READY" % _block_name())
	else:
		selected_party_index = -1
		enemy_action_queue = _enemy_indices_for_block(block_index)
		for enemy_index in enemy_action_queue:
			enemies[enemy_index]["action_gauge"] = MAX_ACTION_GAUGE
			enemies[enemy_index]["basic_attack_uses"] = 0
		enemy_action_timer = ENEMY_ACTION_DELAY
		_set_feedback("%s — ENEMIES ASSESS THE FIELD" % _block_name())


func _is_party_block() -> bool:
	return current_block_index == 0 or current_block_index == 2


func _active_party_indices() -> Array[int]:
	var result: Array[int] = []
	if current_block_index == 0:
		if bool(party[0]["alive"]):
			result.append(0)
		if bool(party[1]["alive"]):
			result.append(1)
	elif current_block_index == 2:
		if bool(party[2]["alive"]):
			result.append(2)
	return result


func _enemy_indices_for_block(block_index: int) -> Array[int]:
	var result: Array[int] = []
	if block_index == 1:
		for enemy_index in [0, 1]:
			if bool(enemies[enemy_index]["alive"]):
				result.append(enemy_index)
	elif block_index == 3 and bool(enemies[2]["alive"]):
		result.append(2)
	return result


func _block_has_living_actor(block_index: int) -> bool:
	if block_index == 0:
		return bool(party[0]["alive"]) or bool(party[1]["alive"])
	if block_index == 1:
		return bool(enemies[0]["alive"]) or bool(enemies[1]["alive"])
	if block_index == 2:
		return bool(party[2]["alive"])
	if block_index == 3:
		return bool(enemies[2]["alive"])
	return false


func _block_name() -> String:
	match current_block_index:
		0:
			return "ARCHER + WARRIOR"
		1:
			return "SLUDGE BLOCK"
		2:
			return "MAGE"
		3:
			return "TOAD BLOCK"
	return "UNKNOWN BLOCK"


func _block_short_name() -> String:
	match current_block_index:
		0:
			return "A + W"
		1:
			return "SLUDGES"
		2:
			return "MAGE"
		3:
			return "TOAD"
	return "UNKNOWN"


func _cycle_active_selection() -> void:
	var active_indices = _active_party_indices()
	if active_indices.size() <= 1:
		return
	var current_position = active_indices.find(selected_party_index)
	var next_position = (current_position + 1) % active_indices.size()
	_select_party_member(active_indices[next_position])


func _select_party_member(party_index: int) -> void:
	if battle_state != BATTLE_ACTIVE or not bool(party[party_index]["alive"]):
		return
	if not (party_index in _active_party_indices()):
		_set_feedback("%s IS WAITING FOR INITIATIVE" % String(party[party_index]["name"]))
		return

	selected_party_index = party_index
	click_target_active = false
	attack_mode_active = false
	confirm_end_block = false
	_set_feedback("%s SELECTED" % String(party[party_index]["name"]))


func _selected_can_pay_attack() -> bool:
	if selected_party_index < 0 or selected_party_index >= party.size():
		return false
	if not bool(party[selected_party_index]["alive"]):
		return false
	var attack: Dictionary = party[selected_party_index]["attack"]
	return float(party[selected_party_index]["action_gauge"]) + 0.001 >= float(attack["cost"])


func _basic_attack_use_limit(actor: Dictionary) -> int:
	var attack: Dictionary = actor["attack"]
	return maxi(0, int(attack["uses_per_turn"]) + int(actor["basic_attack_use_modifier"]))


func _basic_attack_available(actor: Dictionary) -> bool:
	return int(actor["basic_attack_uses"]) < _basic_attack_use_limit(actor)


func _selected_has_basic_attack_use() -> bool:
	if selected_party_index < 0 or selected_party_index >= party.size():
		return false
	return bool(party[selected_party_index]["alive"]) and _basic_attack_available(party[selected_party_index])


func _selected_can_basic_attack() -> bool:
	return _selected_has_basic_attack_use() and _selected_can_pay_attack()


func _toggle_attack_mode() -> void:
	if battle_state != BATTLE_ACTIVE or not _is_party_block() or selected_party_index < 0:
		return
	if attack_mode_active:
		_cancel_attack_mode("ATTACK CANCELED")
		return
	if not _selected_has_basic_attack_use():
		_set_feedback("BASIC ATTACK ALREADY USED THIS TURN")
		return
	if not _selected_can_pay_attack():
		_set_feedback("INSUFFICIENT ACTION GAUGE")
		return
	attack_mode_active = true
	click_target_active = false
	confirm_end_block = false
	var attack: Dictionary = party[selected_party_index]["attack"]
	_set_feedback("%s — SELECT A TARGET" % String(attack["name"]))


func _cancel_attack_mode(message: String) -> void:
	attack_mode_active = false
	if message != "":
		_set_feedback(message)


func _handle_left_click(click_position: Vector2) -> bool:
	if battle_state != BATTLE_ACTIVE:
		return false

	if confirm_end_block:
		confirm_end_block = false
		_set_feedback("END BLOCK CANCELED")
		return true

	var clicked_party_index = _party_index_at_point(click_position)
	if clicked_party_index >= 0:
		_select_party_member(clicked_party_index)
		return true

	var clicked_hud_index = _hud_index_at_point(click_position)
	if clicked_hud_index >= 0:
		_select_party_member(clicked_hud_index)
		return true

	if not _is_party_block() or not PLAYABLE_RECT.has_point(click_position):
		return false

	if attack_mode_active:
		var target = _attack_target_at_point(click_position)
		if target.is_empty():
			_set_feedback("SELECT AN ENEMY OR COMPATIBLE OBJECT — RIGHT CLICK CANCELS")
			return true
		var attack_preview = _attack_preview(target)
		if not bool(attack_preview["in_range"]):
			_set_feedback("OUT OF RANGE")
			return true
		if not bool(attack_preview["affordable"]):
			_set_feedback("INSUFFICIENT ACTION GAUGE")
			return true
		_resolve_party_attack(target, attack_preview)
		return true

	var preview = _movement_preview(click_position)
	if not bool(preview["valid"]):
		_set_feedback(String(preview["reason"]))
		return true
	if not bool(preview["affordable"]):
		_set_feedback("INSUFFICIENT ACTION GAUGE")
		return true

	var preview_destination: Vector2 = preview["destination"]
	click_target = preview_destination
	click_target_active = true
	_set_feedback("MOVING TO DESTINATION — WASD TAKES CONTROL")
	return true


func _party_index_at_point(point: Vector2) -> int:
	for party_index in range(party.size()):
		if not bool(party[party_index]["alive"]):
			continue
		var actor_position: Vector2 = party[party_index]["position"]
		if _actor_footprint(actor_position).grow(5.0).has_point(point):
			return party_index
	return -1


func _hud_index_at_point(point: Vector2) -> int:
	for party_index in range(3):
		if _hud_panel_rect(party_index).has_point(point):
			return party_index
	return -1


func _attack_target_at_point(point: Vector2) -> Dictionary:
	for enemy_index in range(enemies.size()):
		if not bool(enemies[enemy_index]["alive"]):
			continue
		var enemy_position: Vector2 = enemies[enemy_index]["position"]
		if _actor_footprint(enemy_position).grow(5.0).has_point(point):
			return {"kind": "enemy", "index": enemy_index}

	for object_index in range(environment_objects.size()):
		var object_data: Dictionary = environment_objects[object_index]
		var object_rect: Rect2 = object_data["rect"]
		if bool(object_data["intact"]) and object_rect.grow(3.0).has_point(point):
			return {"kind": "object", "index": object_index}
	return {}


func _all_attack_targets() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for enemy_index in range(enemies.size()):
		if bool(enemies[enemy_index]["alive"]):
			result.append({"kind": "enemy", "index": enemy_index})
	for object_index in range(environment_objects.size()):
		if bool(environment_objects[object_index]["intact"]):
			result.append({"kind": "object", "index": object_index})
	return result


func _target_rect(target: Dictionary) -> Rect2:
	if String(target["kind"]) == "enemy":
		var enemy_index = int(target["index"])
		return _actor_footprint(enemies[enemy_index]["position"])
	return environment_objects[int(target["index"])]["rect"]


func _target_name(target: Dictionary) -> String:
	if String(target["kind"]) == "enemy":
		return String(enemies[int(target["index"])]["name"])
	return String(environment_objects[int(target["index"])]["name"])


func _target_hp(target: Dictionary) -> int:
	if String(target["kind"]) == "enemy":
		return int(enemies[int(target["index"])]["hp"])
	return int(environment_objects[int(target["index"])]["hp"])


func _target_max_hp(target: Dictionary) -> int:
	if String(target["kind"]) == "enemy":
		return int(enemies[int(target["index"])]["max_hp"])
	return int(environment_objects[int(target["index"])]["max_hp"])


func _target_dodge(target: Dictionary) -> float:
	if String(target["kind"]) == "enemy":
		return float(enemies[int(target["index"])]["dodge"])
	return 0.0


func _attack_preview(target: Dictionary) -> Dictionary:
	if selected_party_index < 0 or target.is_empty():
		return {}
	var actor: Dictionary = party[selected_party_index]
	var attack: Dictionary = actor["attack"]
	var source_position: Vector2 = actor["position"]
	var target_rect = _target_rect(target)
	var in_range = _range_reaches_rect(source_position, target_rect, float(attack["range"]))
	var target_center = target_rect.position + target_rect.size * 0.5
	var covered = bool(attack["ranged"]) and _has_partial_cover(source_position, target_center, target)
	var accuracy = float(attack["accuracy"]) - _target_dodge(target)
	if covered:
		accuracy -= PARTIAL_COVER_PENALTY
	var cost = float(attack["cost"])
	return {
		"target": target,
		"target_rect": target_rect,
		"in_range": in_range,
		"affordable": float(actor["action_gauge"]) + 0.001 >= cost,
		"valid": in_range,
		"cost": cost,
		"accuracy": accuracy,
		"damage": int(attack["damage"]),
		"covered": covered,
		"range": float(attack["range"]),
		"attack_name": String(attack["name"])
	}


func _current_attack_preview() -> Dictionary:
	if not attack_mode_active or selected_party_index < 0:
		return {}
	var hovered_target = _attack_target_at_point(get_local_mouse_position())
	if hovered_target.is_empty():
		return {}
	return _attack_preview(hovered_target)


func _resolve_party_attack(target: Dictionary, preview: Dictionary) -> void:
	var actor: Dictionary = party[selected_party_index]
	var attack: Dictionary = actor["attack"]
	party[selected_party_index]["action_gauge"] = maxf(
		0.0,
		float(actor["action_gauge"]) - float(attack["cost"])
	)
	party[selected_party_index]["basic_attack_uses"] = int(actor["basic_attack_uses"]) + 1
	click_target_active = false

	var accuracy = float(preview["accuracy"])
	var hit = randomizer.randf_range(0.0, 100.0) < maxf(0.0, accuracy)
	if not hit:
		_set_feedback("%s MISSES %s" % [String(attack["name"]), _target_name(target)])
	else:
		_apply_party_attack_damage(target, int(attack["damage"]), String(attack["name"]))

	_check_battle_result()
	if battle_state != BATTLE_ACTIVE:
		attack_mode_active = false
		return
	if not _has_affordable_in_range_target():
		attack_mode_active = false


func _apply_party_attack_damage(target: Dictionary, damage: int, attack_name: String) -> void:
	if String(target["kind"]) == "enemy":
		var enemy_index = int(target["index"])
		enemies[enemy_index]["hp"] = maxi(0, int(enemies[enemy_index]["hp"]) - damage)
		if int(enemies[enemy_index]["hp"]) <= 0:
			enemies[enemy_index]["alive"] = false
			_set_feedback("%s DEALS %d — %s DEFEATED" % [attack_name, damage, String(enemies[enemy_index]["name"])])
		else:
			_set_feedback("%s DEALS %d TO %s" % [attack_name, damage, String(enemies[enemy_index]["name"])])
		return

	_damage_environment_object(int(target["index"]), damage, attack_name)


func _damage_environment_object(object_index: int, damage: int, attack_name: String) -> void:
	var object_data: Dictionary = environment_objects[object_index]
	if String(object_data["kind"]) == "barrel":
		environment_objects[object_index]["intact"] = false
		environment_objects[object_index]["hp"] = 0
		oil_surface_active = true
		_set_feedback("%s RUPTURES THE BARREL — OILED SURFACE CREATED" % attack_name)
		return

	environment_objects[object_index]["hp"] = maxi(0, int(object_data["hp"]) - damage)
	if int(environment_objects[object_index]["hp"]) <= 0:
		environment_objects[object_index]["intact"] = false
		_set_feedback("%s DEALS %d — CRATE DESTROYED" % [attack_name, damage])
	else:
		_set_feedback("%s DEALS %d TO CRATE" % [attack_name, damage])


func _has_affordable_in_range_target() -> bool:
	if not _selected_can_basic_attack():
		return false
	for target in _all_attack_targets():
		var preview = _attack_preview(target)
		if bool(preview["in_range"]) and bool(preview["affordable"]):
			return true
	return false


func _range_reaches_rect(source_position: Vector2, target_rect: Rect2, attack_range: float) -> bool:
	var closest_point = Vector2(
		clampf(source_position.x, target_rect.position.x, target_rect.end.x),
		clampf(source_position.y, target_rect.position.y, target_rect.end.y)
	)
	return source_position.distance_to(closest_point) <= attack_range + 0.001


func _has_partial_cover(source_position: Vector2, target_position: Vector2, target: Dictionary) -> bool:
	for object_index in range(environment_objects.size()):
		var object_data: Dictionary = environment_objects[object_index]
		if not bool(object_data["intact"]) or String(object_data["kind"]) != "crate":
			continue
		if String(target["kind"]) == "object" and int(target["index"]) == object_index:
			continue
		if _segment_intersects_rect(source_position, target_position, object_data["rect"]):
			return true
	return false


func _update_selected_movement(delta: float) -> void:
	if selected_party_index < 0 or not bool(party[selected_party_index]["alive"]):
		return

	var keyboard_direction = _keyboard_direction()
	if keyboard_direction != Vector2.ZERO:
		if attack_mode_active:
			attack_mode_active = false
			_set_feedback("ATTACK CANCELED — MOVING")
		click_target_active = false
		_move_selected(keyboard_direction * MOVE_SPEED * delta)
		return

	if not click_target_active:
		return

	var actor_position: Vector2 = party[selected_party_index]["position"]
	var to_target = click_target - actor_position
	if to_target.length() <= 1.0:
		click_target_active = false
		return

	var motion = to_target.normalized() * minf(MOVE_SPEED * delta, to_target.length())
	var moved = _move_selected(motion)
	var remaining_position: Vector2 = party[selected_party_index]["position"]
	if not moved:
		click_target_active = false
		_set_feedback("MOVEMENT STOPPED")
	elif remaining_position.distance_to(click_target) <= 1.0:
		click_target_active = false
	elif float(party[selected_party_index]["action_gauge"]) <= 0.01:
		click_target_active = false
		_set_feedback("ACTION GAUGE EMPTY")


func _keyboard_direction() -> Vector2:
	var direction = Vector2.ZERO
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1.0
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		direction.y += 1.0
	return direction.normalized()


func _move_selected(requested_motion: Vector2) -> bool:
	if selected_party_index < 0 or requested_motion == Vector2.ZERO:
		return false

	var start_position: Vector2 = party[selected_party_index]["position"]
	var available_gauge = float(party[selected_party_index]["action_gauge"])
	if available_gauge <= 0.0:
		return false

	var resolved_position = _resolve_motion(start_position, requested_motion)
	var full_cost = _movement_cost(start_position, resolved_position)

	if full_cost > available_gauge:
		var low = 0.0
		var high = 1.0
		var best_position = start_position
		for _iteration in range(10):
			var midpoint = (low + high) * 0.5
			var candidate = _resolve_motion(start_position, requested_motion * midpoint)
			var candidate_cost = _movement_cost(start_position, candidate)
			if candidate_cost <= available_gauge:
				low = midpoint
				best_position = candidate
			else:
				high = midpoint
		resolved_position = best_position
		full_cost = _movement_cost(start_position, resolved_position)

	if resolved_position.distance_to(start_position) <= 0.01:
		return false

	party[selected_party_index]["position"] = resolved_position
	party[selected_party_index]["action_gauge"] = maxf(0.0, available_gauge - full_cost)
	return true


func _resolve_motion(start_position: Vector2, requested_motion: Vector2) -> Vector2:
	var resolved = start_position
	var x_candidate = Vector2(start_position.x + requested_motion.x, start_position.y)
	if _position_is_valid(x_candidate, selected_party_index):
		resolved.x = x_candidate.x

	var y_candidate = Vector2(resolved.x, start_position.y + requested_motion.y)
	if _position_is_valid(y_candidate, selected_party_index):
		resolved.y = y_candidate.y

	return resolved


func _position_is_valid(position_value: Vector2, moving_party_index: int) -> bool:
	var footprint = _actor_footprint(position_value)
	if not PLAYABLE_RECT.encloses(footprint):
		return false

	for obstacle in _blocking_rects():
		if footprint.intersects(obstacle, true):
			return false

	for party_index in range(party.size()):
		if party_index == moving_party_index:
			continue
		if not bool(party[party_index]["alive"]):
			continue
		var other_position: Vector2 = party[party_index]["position"]
		if footprint.intersects(_actor_footprint(other_position), true):
			return false

	for enemy in enemies:
		if not bool(enemy["alive"]):
			continue
		var enemy_position: Vector2 = enemy["position"]
		if footprint.intersects(_actor_footprint(enemy_position), true):
			return false

	return true


func _movement_cost(from_position: Vector2, to_position: Vector2) -> float:
	var distance_cost = from_position.distance_to(to_position) * MOVE_COST_PER_PIXEL
	var transition_count = absi(_zone_index(from_position.x) - _zone_index(to_position.x))
	return distance_cost + transition_count * ZONE_TRANSITION_COST


func _movement_preview(destination: Vector2) -> Dictionary:
	if selected_party_index < 0:
		return {
			"valid": false,
			"affordable": false,
			"cost": 0.0,
			"destination": destination,
			"reason": "NO ACTIVE ACTOR"
		}

	var start_position: Vector2 = party[selected_party_index]["position"]
	var destination_footprint = _actor_footprint(destination)
	if not PLAYABLE_RECT.encloses(destination_footprint):
		return {
			"valid": false,
			"affordable": false,
			"cost": 0.0,
			"destination": destination,
			"reason": "OUT OF BOUNDS"
		}

	if not _position_is_valid(destination, selected_party_index):
		return {
			"valid": false,
			"affordable": false,
			"cost": 0.0,
			"destination": destination,
			"reason": "SPACE BLOCKED"
		}

	if not _direct_path_is_clear(start_position, destination, selected_party_index):
		return {
			"valid": false,
			"affordable": false,
			"cost": 0.0,
			"destination": destination,
			"reason": "ROUTE BLOCKED"
		}

	var cost = _movement_cost(start_position, destination)
	var available_gauge = float(party[selected_party_index]["action_gauge"])
	return {
		"valid": true,
		"affordable": cost <= available_gauge + 0.001,
		"cost": cost,
		"destination": destination,
		"reason": ""
	}


func _direct_path_is_clear(from_position: Vector2, to_position: Vector2, moving_party_index: int) -> bool:
	for obstacle in _blocking_rects():
		var expanded = obstacle.grow_individual(
			ACTOR_HALF_SIZE.x,
			ACTOR_HALF_SIZE.y,
			ACTOR_HALF_SIZE.x,
			ACTOR_HALF_SIZE.y
		)
		if _segment_intersects_rect(from_position, to_position, expanded):
			return false

	for party_index in range(party.size()):
		if party_index == moving_party_index:
			continue
		if not bool(party[party_index]["alive"]):
			continue
		var party_position: Vector2 = party[party_index]["position"]
		var expanded_party = _actor_footprint(party_position).grow_individual(
			ACTOR_HALF_SIZE.x,
			ACTOR_HALF_SIZE.y,
			ACTOR_HALF_SIZE.x,
			ACTOR_HALF_SIZE.y
		)
		if _segment_intersects_rect(from_position, to_position, expanded_party):
			return false

	for enemy in enemies:
		if not bool(enemy["alive"]):
			continue
		var enemy_position: Vector2 = enemy["position"]
		var expanded_enemy = _actor_footprint(enemy_position).grow_individual(
			ACTOR_HALF_SIZE.x,
			ACTOR_HALF_SIZE.y,
			ACTOR_HALF_SIZE.x,
			ACTOR_HALF_SIZE.y
		)
		if _segment_intersects_rect(from_position, to_position, expanded_enemy):
			return false

	return true


func _segment_intersects_rect(from_position: Vector2, to_position: Vector2, rect: Rect2) -> bool:
	if rect.has_point(from_position) or rect.has_point(to_position):
		return true

	var direction = to_position - from_position
	var p = [-direction.x, direction.x, -direction.y, direction.y]
	var q = [
		from_position.x - rect.position.x,
		rect.end.x - from_position.x,
		from_position.y - rect.position.y,
		rect.end.y - from_position.y
	]
	var minimum_t = 0.0
	var maximum_t = 1.0

	for index in range(4):
		if is_zero_approx(float(p[index])):
			if float(q[index]) < 0.0:
				return false
			continue

		var ratio = float(q[index]) / float(p[index])
		if float(p[index]) < 0.0:
			minimum_t = maxf(minimum_t, ratio)
		else:
			maximum_t = minf(maximum_t, ratio)
		if minimum_t > maximum_t:
			return false

	return true


func _blocking_rects() -> Array[Rect2]:
	var result: Array[Rect2] = []
	for object_data in environment_objects:
		if bool(object_data["intact"]):
			result.append(object_data["rect"])
	return result


func _actor_footprint(position_value: Vector2) -> Rect2:
	return Rect2(position_value - ACTOR_HALF_SIZE, ACTOR_HALF_SIZE * 2.0)


func _zone_index(x_position: float) -> int:
	return clampi(floori(x_position / BAND_WIDTH), 0, 4)


func _zone_name(zone_index: int) -> String:
	var names: Array[String] = ["ENEMY BACK", "ENEMY MID", "MELEE", "PARTY MID", "PARTY BACK"]
	return names[zone_index]


func _generate_deployment() -> void:
	var party_y_values = [82.0, 150.0, 243.0]
	var enemy_y_values = [78.0, 164.0, 234.0]
	party_y_values.shuffle()
	enemy_y_values.shuffle()

	for party_index in range(party.size()):
		party[party_index]["position"] = Vector2(
			randomizer.randf_range(402.0, 494.0),
			float(party_y_values[party_index])
		)

	for enemy_index in range(enemies.size()):
		enemies[enemy_index]["position"] = Vector2(
			randomizer.randf_range(146.0, 238.0),
			float(enemy_y_values[enemy_index])
		)


func _reroll_deployment() -> void:
	_reset_battle()


func _reset_battle() -> void:
	battle_state = BATTLE_ACTIVE
	initiative_set = 1
	current_block_index = 0
	selected_party_index = 0
	click_target_active = false
	attack_mode_active = false
	confirm_end_block = false
	enemy_action_queue.clear()
	_build_combatant_data()
	_build_environment_data()
	_generate_deployment()
	_enter_block(0, true)
	_set_feedback("BATTLE RESET — NEW DEPLOYMENT")
	queue_redraw()


func _set_feedback(message: String) -> void:
	feedback_text = message
	feedback_timer = 1.6


func _current_preview() -> Dictionary:
	if not _is_party_block() or selected_party_index < 0:
		return {}

	if attack_mode_active:
		return _current_attack_preview()

	if click_target_active:
		return _movement_preview(click_target)

	var mouse_position = get_local_mouse_position()
	if not PLAYABLE_RECT.has_point(mouse_position):
		return {}
	if _party_index_at_point(mouse_position) >= 0:
		return {}
	return _movement_preview(mouse_position)


func _update_enemy_block(delta: float) -> void:
	enemy_action_timer -= delta
	if enemy_action_timer > 0.0:
		return

	while not enemy_action_queue.is_empty() and not bool(enemies[int(enemy_action_queue[0])]["alive"]):
		enemy_action_queue.pop_front()

	if enemy_action_queue.is_empty():
		_advance_block()
		return

	var enemy_index = int(enemy_action_queue.pop_front())
	_perform_enemy_turn(enemy_index)
	if battle_state == BATTLE_ACTIVE:
		enemy_action_timer = ENEMY_ACTION_DELAY


func _perform_enemy_turn(enemy_index: int) -> void:
	if not bool(enemies[enemy_index]["alive"]):
		return
	var party_index = _nearest_living_party_index(enemies[enemy_index]["position"])
	if party_index < 0:
		_check_battle_result()
		return

	var moved = false
	var preview = _enemy_attack_preview(enemy_index, party_index)
	if not bool(preview["in_range"]):
		moved = _move_enemy_toward_party(enemy_index, party_index)
		preview = _enemy_attack_preview(enemy_index, party_index)

	if bool(preview["in_range"]) and bool(preview["affordable"]):
		_resolve_enemy_attack(enemy_index, party_index, preview)
	elif moved:
		_set_feedback("%s MOVES TOWARD %s" % [String(enemies[enemy_index]["name"]), String(party[party_index]["name"])])
	else:
		_set_feedback("%s CANNOT REACH A TARGET" % String(enemies[enemy_index]["name"]))


func _nearest_living_party_index(from_position: Vector2) -> int:
	var best_index = -1
	var best_distance = 1000000.0
	for party_index in range(party.size()):
		if not bool(party[party_index]["alive"]):
			continue
		var party_position: Vector2 = party[party_index]["position"]
		var distance = from_position.distance_squared_to(party_position)
		if distance < best_distance:
			best_distance = distance
			best_index = party_index
	return best_index


func _enemy_attack_preview(enemy_index: int, party_index: int) -> Dictionary:
	var enemy: Dictionary = enemies[enemy_index]
	var attack: Dictionary = enemy["attack"]
	var source_position: Vector2 = enemy["position"]
	var target_position: Vector2 = party[party_index]["position"]
	var target_rect = _actor_footprint(target_position)
	var in_range = _range_reaches_rect(source_position, target_rect, float(attack["range"]))
	var target_ref = {"kind": "party", "index": party_index}
	var covered = bool(attack["ranged"]) and _has_partial_cover(source_position, target_position, target_ref)
	var accuracy = float(attack["accuracy"]) - float(party[party_index]["dodge"])
	if covered:
		accuracy -= PARTIAL_COVER_PENALTY
	return {
		"in_range": in_range,
		"affordable": _basic_attack_available(enemy) and float(enemy["action_gauge"]) + 0.001 >= float(attack["cost"]),
		"accuracy": accuracy,
		"damage": int(attack["damage"]),
		"covered": covered
	}


func _resolve_enemy_attack(enemy_index: int, party_index: int, preview: Dictionary) -> void:
	var enemy: Dictionary = enemies[enemy_index]
	var attack: Dictionary = enemy["attack"]
	enemies[enemy_index]["action_gauge"] = maxf(
		0.0,
		float(enemy["action_gauge"]) - float(attack["cost"])
	)
	enemies[enemy_index]["basic_attack_uses"] = int(enemy["basic_attack_uses"]) + 1
	var accuracy = float(preview["accuracy"])
	var hit = randomizer.randf_range(0.0, 100.0) < maxf(0.0, accuracy)
	if not hit:
		_set_feedback("%s MISSES %s" % [String(attack["name"]), String(party[party_index]["name"])])
		return

	var damage = int(attack["damage"])
	party[party_index]["hp"] = maxi(0, int(party[party_index]["hp"]) - damage)
	if int(party[party_index]["hp"]) <= 0:
		party[party_index]["alive"] = false
		_set_feedback("%s DEALS %d — %s DEFEATED" % [String(attack["name"]), damage, String(party[party_index]["name"])])
	else:
		_set_feedback("%s DEALS %d TO %s" % [String(attack["name"]), damage, String(party[party_index]["name"])])
	_check_battle_result()


func _move_enemy_toward_party(enemy_index: int, party_index: int) -> bool:
	var enemy: Dictionary = enemies[enemy_index]
	var attack: Dictionary = enemy["attack"]
	var start_position: Vector2 = enemy["position"]
	var target_position: Vector2 = party[party_index]["position"]
	var target_rect = _actor_footprint(target_position)
	var available_gauge = float(enemy["action_gauge"])
	var movement_budget = maxf(0.0, available_gauge - float(attack["cost"]))
	if movement_budget <= 0.01:
		return false

	var approach_radius = float(attack["range"]) + 6.0
	var starting_angle = (start_position - target_position).angle()
	var offsets = [0.0, 0.40, -0.40, 0.80, -0.80, 1.20, -1.20, 1.60, -1.60, 2.00, -2.00, 2.40, -2.40, PI]
	var best_destination = start_position
	var best_cost = 1000000.0

	for angle_offset in offsets:
		var candidate = target_position + Vector2.RIGHT.rotated(starting_angle + float(angle_offset)) * approach_radius
		if not _enemy_position_is_valid(candidate, enemy_index):
			continue
		if not _direct_enemy_path_is_clear(start_position, candidate, enemy_index):
			continue
		if not _range_reaches_rect(candidate, target_rect, float(attack["range"])):
			continue
		var candidate_cost = _movement_cost(start_position, candidate)
		if candidate_cost <= movement_budget + 0.001 and candidate_cost < best_cost:
			best_destination = candidate
			best_cost = candidate_cost

	if best_destination.distance_to(start_position) <= 0.01:
		best_destination = _best_enemy_approach_step(enemy_index, target_rect, movement_budget)
		best_cost = _movement_cost(start_position, best_destination)

	if best_destination.distance_to(start_position) <= 0.01 or best_cost > movement_budget + 0.001:
		return false

	enemies[enemy_index]["position"] = best_destination
	enemies[enemy_index]["action_gauge"] = maxf(0.0, available_gauge - best_cost)
	return true


func _best_enemy_approach_step(enemy_index: int, target_rect: Rect2, movement_budget: float) -> Vector2:
	var start_position: Vector2 = enemies[enemy_index]["position"]
	var target_position = target_rect.position + target_rect.size * 0.5
	var base_direction = start_position.direction_to(target_position)
	var maximum_distance = minf(170.0, movement_budget / MOVE_COST_PER_PIXEL)
	var steering_offsets = [0.0, 0.32, -0.32, 0.64, -0.64, 0.96, -0.96, 1.28, -1.28]
	var best_position = start_position
	var best_distance = _distance_from_point_to_rect(start_position, target_rect)

	for steering_offset in steering_offsets:
		var direction = base_direction.rotated(float(steering_offset))
		var candidate_best = start_position
		for step_index in range(1, 41):
			var amount = float(step_index) / 40.0
			var candidate = start_position + direction * maximum_distance * amount
			if not _enemy_position_is_valid(candidate, enemy_index):
				break
			if not _direct_enemy_path_is_clear(start_position, candidate, enemy_index):
				break
			if _movement_cost(start_position, candidate) > movement_budget + 0.001:
				break
			candidate_best = candidate
		var candidate_distance = _distance_from_point_to_rect(candidate_best, target_rect)
		if candidate_distance < best_distance:
			best_distance = candidate_distance
			best_position = candidate_best

	return best_position


func _distance_from_point_to_rect(point: Vector2, rect: Rect2) -> float:
	var closest_point = Vector2(
		clampf(point.x, rect.position.x, rect.end.x),
		clampf(point.y, rect.position.y, rect.end.y)
	)
	return point.distance_to(closest_point)


func _enemy_position_is_valid(position_value: Vector2, moving_enemy_index: int) -> bool:
	var footprint = _actor_footprint(position_value)
	if not PLAYABLE_RECT.encloses(footprint):
		return false
	for obstacle in _blocking_rects():
		if footprint.intersects(obstacle, true):
			return false
	for party_member in party:
		if not bool(party_member["alive"]):
			continue
		if footprint.intersects(_actor_footprint(party_member["position"]), true):
			return false
	for enemy_index in range(enemies.size()):
		if enemy_index == moving_enemy_index or not bool(enemies[enemy_index]["alive"]):
			continue
		if footprint.intersects(_actor_footprint(enemies[enemy_index]["position"]), true):
			return false
	return true


func _direct_enemy_path_is_clear(from_position: Vector2, to_position: Vector2, moving_enemy_index: int) -> bool:
	var hopping = String(enemies[moving_enemy_index]["id"]) == "toad"
	for object_data in environment_objects:
		if not bool(object_data["intact"]):
			continue
		if hopping and String(object_data["kind"]) == "crate":
			continue
		var obstacle: Rect2 = object_data["rect"]
		var expanded = obstacle.grow_individual(ACTOR_HALF_SIZE.x, ACTOR_HALF_SIZE.y, ACTOR_HALF_SIZE.x, ACTOR_HALF_SIZE.y)
		if _segment_intersects_rect(from_position, to_position, expanded):
			return false
	if not hopping:
		for party_member in party:
			if not bool(party_member["alive"]):
				continue
			var party_rect = _actor_footprint(party_member["position"]).grow_individual(ACTOR_HALF_SIZE.x, ACTOR_HALF_SIZE.y, ACTOR_HALF_SIZE.x, ACTOR_HALF_SIZE.y)
			if _segment_intersects_rect(from_position, to_position, party_rect):
				return false
		for enemy_index in range(enemies.size()):
			if enemy_index == moving_enemy_index or not bool(enemies[enemy_index]["alive"]):
				continue
			var enemy_rect = _actor_footprint(enemies[enemy_index]["position"]).grow_individual(ACTOR_HALF_SIZE.x, ACTOR_HALF_SIZE.y, ACTOR_HALF_SIZE.x, ACTOR_HALF_SIZE.y)
			if _segment_intersects_rect(from_position, to_position, enemy_rect):
				return false
	return true


func _check_battle_result() -> void:
	var living_party = 0
	var living_enemies = 0
	for party_member in party:
		if bool(party_member["alive"]):
			living_party += 1
	for enemy in enemies:
		if bool(enemy["alive"]):
			living_enemies += 1

	if living_enemies == 0:
		_set_battle_result(BATTLE_VICTORY)
	elif living_party == 0:
		_set_battle_result(BATTLE_DEFEAT)


func _set_battle_result(result: String) -> void:
	battle_state = result
	click_target_active = false
	attack_mode_active = false
	confirm_end_block = false
	enemy_action_queue.clear()
	selected_party_index = -1
	feedback_timer = 0.0
	queue_redraw()


func _draw_initiative_ribbon(ink: Color, white: Color, font: Font) -> void:
	draw_rect(Rect2(0.0, 0.0, 640.0, INITIATIVE_HEIGHT), ink, true)
	draw_string(font, Vector2(7.0, 12.0), "INIT", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 7, white)
	draw_string(font, Vector2(7.0, 27.0), "SET %d" % initiative_set, HORIZONTAL_ALIGNMENT_LEFT, 30.0, 6, Color(0.72, 0.72, 0.72))

	_draw_group_slot(Rect2(39.0, 3.0, 66.0, 30.0), current_block_index == 0, white)
	_draw_initiative_portrait(Rect2(43.0, 7.0, 24.0, 22.0), "A", ink, white, font, selected_party_index == 0)
	_draw_initiative_portrait(Rect2(75.0, 7.0, 24.0, 22.0), "W", ink, white, font, selected_party_index == 1)

	_draw_group_slot(Rect2(116.0, 3.0, 58.0, 30.0), current_block_index == 1, Color(0.64, 0.64, 0.64))
	_draw_initiative_portrait(Rect2(121.0, 7.0, 20.0, 22.0), "S", Color(0.28, 0.28, 0.28), white, font, false)
	_draw_initiative_portrait(Rect2(148.0, 7.0, 20.0, 22.0), "S", Color(0.28, 0.28, 0.28), white, font, false)

	_draw_group_slot(Rect2(183.0, 3.0, 30.0, 30.0), current_block_index == 2, white)
	_draw_initiative_portrait(Rect2(186.0, 7.0, 24.0, 22.0), "M", ink, white, font, selected_party_index == 2)

	_draw_group_slot(Rect2(218.0, 3.0, 30.0, 30.0), current_block_index == 3, Color(0.64, 0.64, 0.64))
	_draw_initiative_portrait(Rect2(221.0, 7.0, 24.0, 22.0), "T", Color(0.28, 0.28, 0.28), white, font, false)

	if not bool(party[0]["alive"]):
		_draw_defeated_mark(Rect2(43.0, 7.0, 24.0, 22.0), ink)
	if not bool(party[1]["alive"]):
		_draw_defeated_mark(Rect2(75.0, 7.0, 24.0, 22.0), ink)
	if not bool(enemies[0]["alive"]):
		_draw_defeated_mark(Rect2(121.0, 7.0, 20.0, 22.0), white)
	if not bool(enemies[1]["alive"]):
		_draw_defeated_mark(Rect2(148.0, 7.0, 20.0, 22.0), white)
	if not bool(party[2]["alive"]):
		_draw_defeated_mark(Rect2(186.0, 7.0, 24.0, 22.0), ink)
	if not bool(enemies[2]["alive"]):
		_draw_defeated_mark(Rect2(221.0, 7.0, 24.0, 22.0), white)


func _draw_defeated_mark(rect: Rect2, color: Color) -> void:
	draw_line(rect.position, rect.end, color, 2.0)
	draw_line(Vector2(rect.end.x, rect.position.y), Vector2(rect.position.x, rect.end.y), color, 2.0)


func _draw_group_slot(rect: Rect2, active: bool, color: Color) -> void:
	draw_rect(rect, Color.WHITE if active else color, false, 3.0 if active else 1.0)


func _draw_initiative_portrait(
	rect: Rect2,
	label_text: String,
	fill: Color,
	text_color: Color,
	font: Font,
	selected: bool
) -> void:
	draw_rect(rect, fill, true)
	draw_rect(rect, Color.WHITE if selected else text_color, false, 2.0 if selected else 1.0)
	draw_string(font, rect.position + Vector2(0.0, 16.0), label_text, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 10, text_color)


func _draw_battlefield(ink: Color, font: Font) -> void:
	var band_names = ["ENEMY BACK", "ENEMY MID", "MELEE", "PARTY MID", "PARTY BACK"]
	var fills = [0.74, 0.79, 0.84, 0.79, 0.74]

	for index in range(5):
		var rect = Rect2(index * BAND_WIDTH, INITIATIVE_HEIGHT, BAND_WIDTH, BATTLEFIELD_HEIGHT)
		var tone = float(fills[index])
		draw_rect(rect, Color(tone, tone, tone), true)
		draw_rect(rect, ink, false, 1.0)
		draw_string(font, Vector2(rect.position.x + 3.0, 48.0), band_names[index], HORIZONTAL_ALIGNMENT_CENTER, BAND_WIDTH - 6.0, 7, ink)

	for y_position in [92.0, 154.0, 216.0]:
		draw_line(Vector2(0.0, y_position), Vector2(640.0, y_position), Color(0.66, 0.66, 0.66), 1.0)


func _draw_environment(ink: Color, font: Font) -> void:
	for object_data in environment_objects:
		var object_rect: Rect2 = object_data["rect"]
		if bool(object_data["intact"]):
			if String(object_data["kind"]) == "crate":
				_draw_object(object_rect, "CRATE", ink, font)
				_draw_world_health_bar(
					Vector2(object_rect.position.x, object_rect.position.y - 5.0),
					object_rect.size.x,
					float(object_data["hp"]) / float(object_data["max_hp"]),
					ink
				)
			else:
				draw_rect(object_rect, Color(0.39, 0.39, 0.39), true)
				draw_rect(object_rect, ink, false, 2.0)
				draw_string(font, object_rect.position + Vector2(-14.0, object_rect.size.y + 10.0), "OIL", HORIZONTAL_ALIGNMENT_CENTER, object_rect.size.x + 28.0, 7, ink)
		elif String(object_data["kind"]) == "crate":
			draw_line(object_rect.position, object_rect.end, Color(0.50, 0.50, 0.50), 1.0)
			draw_line(Vector2(object_rect.end.x, object_rect.position.y), Vector2(object_rect.position.x, object_rect.end.y), Color(0.50, 0.50, 0.50), 1.0)

	if oil_surface_active:
		var oil_center = OIL_BARREL.position + OIL_BARREL.size * 0.5
		draw_circle(oil_center, OIL_SURFACE_RADIUS, Color(0.31, 0.31, 0.31), true)
		draw_arc(oil_center, OIL_SURFACE_RADIUS, 0.0, TAU, 32, ink, 2.0)
		draw_string(font, oil_center + Vector2(-28.0, 4.0), "OILED", HORIZONTAL_ALIGNMENT_CENTER, 56.0, 7, Color(0.84, 0.84, 0.84))

	draw_circle(Vector2(366.0, 118.0), 18.0, Color(0.68, 0.68, 0.68))
	draw_arc(Vector2(366.0, 118.0), 18.0, 0.0, TAU, 24, ink, 1.0)
	draw_string(font, Vector2(343.0, 144.0), "PUDDLE", HORIZONTAL_ALIGNMENT_CENTER, 48.0, 7, ink)


func _draw_object(rect: Rect2, label_text: String, ink: Color, font: Font) -> void:
	draw_rect(rect, Color(0.49, 0.49, 0.49), true)
	draw_rect(rect, ink, false, 2.0)
	draw_line(rect.position, rect.end, ink, 1.0)
	draw_line(Vector2(rect.end.x, rect.position.y), Vector2(rect.position.x, rect.end.y), ink, 1.0)
	draw_string(font, rect.position + Vector2(-5.0, rect.size.y + 10.0), label_text, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x + 10.0, 6, ink)


func _draw_movement_preview(ink: Color, white: Color, font: Font) -> void:
	if attack_mode_active or battle_state != BATTLE_ACTIVE:
		return
	var preview = _current_preview()
	if preview.is_empty() or selected_party_index < 0:
		return

	var destination: Vector2 = preview["destination"]
	var valid = bool(preview["valid"])
	var affordable = bool(preview["affordable"])
	var line_color = white if valid and affordable else Color(0.30, 0.30, 0.30)

	draw_rect(_actor_footprint(destination), ink, false, 4.0)
	draw_rect(_actor_footprint(destination), line_color, false, 2.0)
	draw_circle(destination, 13.0, line_color, false, 1.0)

	var label_text = ""
	if not valid:
		label_text = String(preview["reason"])
	elif not affordable:
		label_text = "NEED %d AG" % ceili(float(preview["cost"]))
	else:
		label_text = "MOVE -%d AG" % ceili(float(preview["cost"]))

	var label_position = destination + Vector2(-44.0, -19.0)
	label_position.x = clampf(label_position.x, 4.0, 548.0)
	label_position.y = clampf(label_position.y, 60.0, 238.0)
	draw_rect(Rect2(label_position, Vector2(88.0, 13.0)), Color(0.92, 0.92, 0.92), true)
	draw_rect(Rect2(label_position, Vector2(88.0, 13.0)), ink, false, 1.0)
	draw_string(font, label_position + Vector2(2.0, 10.0), label_text, HORIZONTAL_ALIGNMENT_CENTER, 84.0, 6, ink)


func _draw_attack_targeting(ink: Color, white: Color, font: Font) -> void:
	if not attack_mode_active or selected_party_index < 0 or battle_state != BATTLE_ACTIVE:
		return
	var actor: Dictionary = party[selected_party_index]
	var attack: Dictionary = actor["attack"]
	var source_position: Vector2 = actor["position"]
	_draw_clipped_range_circle(source_position, float(attack["range"]), ink, white)

	var mouse_position = get_local_mouse_position()
	for target in _all_attack_targets():
		var preview = _attack_preview(target)
		var target_rect: Rect2 = preview["target_rect"]
		var hovered = target_rect.grow(5.0).has_point(mouse_position)
		var target_color = white if bool(preview["in_range"]) and bool(preview["affordable"]) else Color(0.34, 0.34, 0.34)
		draw_rect(target_rect.grow(3.0), ink, false, 4.0)
		draw_rect(target_rect.grow(3.0), target_color, false, 3.0 if hovered else 1.0)

	var current = _current_attack_preview()
	if current.is_empty():
		return
	var current_target: Dictionary = current["target"]
	var current_rect: Rect2 = current["target_rect"]
	if bool(attack["ranged"]):
		var aim_color = white if bool(current["in_range"]) and bool(current["affordable"]) else Color(0.34, 0.34, 0.34)
		var target_center = current_rect.position + current_rect.size * 0.5
		draw_line(source_position, target_center, ink, 4.0)
		draw_line(source_position, target_center, aim_color, 2.0)
	var label_text = ""
	if not bool(current["in_range"]):
		label_text = "%s  /  OUT OF RANGE  /  AG %d" % [
			_target_name(current_target),
			ceili(float(current["cost"]))
		]
	else:
		label_text = "%s  /  ACC %d%%  /  DMG %d  /  AG %d" % [
			_target_name(current_target),
			roundi(float(current["accuracy"])),
			int(current["damage"]),
			ceili(float(current["cost"]))
		]
		if bool(current["covered"]):
			label_text += "  /  COVER"

	var hp_text = "HP %d/%d" % [_target_hp(current_target), _target_max_hp(current_target)]
	if String(current_target["kind"]) == "object" and String(environment_objects[int(current_target["index"])]["kind"]) == "barrel":
		hp_text = "RUPTURES ON FIRST DAMAGING HIT"
	var label_position = current_rect.position + Vector2(-72.0, -31.0)
	label_position.x = clampf(label_position.x, 4.0, 418.0)
	label_position.y = clampf(label_position.y, 58.0, 228.0)
	var label_rect = Rect2(label_position, Vector2(218.0, 25.0))
	draw_rect(label_rect, Color(0.92, 0.92, 0.92), true)
	draw_rect(label_rect, ink, false, 1.0)
	draw_string(font, label_position + Vector2(3.0, 10.0), label_text, HORIZONTAL_ALIGNMENT_LEFT, 212.0, 6, ink)
	draw_string(font, label_position + Vector2(3.0, 21.0), hp_text, HORIZONTAL_ALIGNMENT_LEFT, 212.0, 6, ink)


func _draw_clipped_range_circle(center: Vector2, radius: float, outer: Color, inner: Color) -> void:
	var battlefield_rect = Rect2(0.0, INITIATIVE_HEIGHT, CANVAS_SIZE.x, BATTLEFIELD_HEIGHT)
	var segment_count = 128
	for segment_index in range(segment_count):
		var angle_a = TAU * float(segment_index) / float(segment_count)
		var angle_b = TAU * float(segment_index + 1) / float(segment_count)
		var point_a = center + Vector2.RIGHT.rotated(angle_a) * radius
		var point_b = center + Vector2.RIGHT.rotated(angle_b) * radius
		if battlefield_rect.has_point(point_a) and battlefield_rect.has_point(point_b):
			draw_line(point_a, point_b, outer, 3.0)
			draw_line(point_a, point_b, inner, 1.0)


func _draw_combatants(ink: Color, font: Font) -> void:
	for party_index in range(party.size()):
		if not bool(party[party_index]["alive"]):
			continue
		var actor_position: Vector2 = party[party_index]["position"]
		_draw_actor(
			actor_position,
			String(party[party_index]["name"]),
			true,
			String(party[party_index]["companion"]),
			party_index == selected_party_index,
			party_index in _active_party_indices(),
			ink,
			font
		)

	for enemy in enemies:
		if not bool(enemy["alive"]):
			continue
		var enemy_position: Vector2 = enemy["position"]
		_draw_actor(
			enemy_position,
			String(enemy["name"]),
			false,
			"",
			false,
			false,
			ink,
			font
		)
		_draw_world_health_bar(
			enemy_position + Vector2(-16.0, -26.0),
			32.0,
			float(enemy["hp"]) / float(enemy["max_hp"]),
			ink
		)


func _draw_world_health_bar(position_value: Vector2, width: float, fill_ratio: float, ink: Color) -> void:
	var rect = Rect2(position_value, Vector2(width, 4.0))
	draw_rect(rect, BAR_TRACK_COLOR, true)
	draw_rect(Rect2(rect.position, Vector2(rect.size.x * clampf(fill_ratio, 0.0, 1.0), rect.size.y)), HEALTH_COLOR, true)
	draw_rect(rect, ink, false, 1.0)


func _draw_actor(
	position_value: Vector2,
	actor_name: String,
	allied: bool,
	companion_code: String,
	selected: bool,
	active: bool,
	ink: Color,
	font: Font
) -> void:
	var footprint = _actor_footprint(position_value)
	var fill = Color(0.96, 0.96, 0.96) if allied else Color(0.30, 0.30, 0.30)
	if allied and not active:
		fill = Color(0.68, 0.68, 0.68)

	draw_rect(footprint, fill, true)
	draw_rect(footprint, ink, false, 2.0 if allied else 1.0)
	if not allied:
		draw_line(footprint.position, footprint.end, Color(0.72, 0.72, 0.72), 1.0)
		draw_line(Vector2(footprint.end.x, footprint.position.y), Vector2(footprint.position.x, footprint.end.y), Color(0.72, 0.72, 0.72), 1.0)

	draw_string(font, position_value + Vector2(-28.0, -15.0), actor_name, HORIZONTAL_ALIGNMENT_CENTER, 56.0, 6, ink)
	draw_arc(position_value, 12.0, 0.0, TAU, 20, ink, 1.0)
	if selected:
		draw_arc(position_value, 16.0, 0.0, TAU, 24, Color.WHITE, 3.0)
		draw_arc(position_value, 18.0, 0.0, TAU, 24, ink, 1.0)

	if companion_code != "":
		var companion_rect = Rect2(position_value + Vector2(8.0, 2.0), Vector2(9.0, 9.0))
		draw_rect(companion_rect, Color(0.52, 0.52, 0.52), true)
		draw_rect(companion_rect, ink, false, 1.0)
		draw_string(font, companion_rect.position + Vector2(0.0, 7.0), companion_code, HORIZONTAL_ALIGNMENT_CENTER, companion_rect.size.x, 6, Color.WHITE)


func _draw_command_status(ink: Color, font: Font) -> void:
	var status_text = ""
	if battle_state == BATTLE_VICTORY:
		status_text = "VICTORY — R RETRY / ESC RETURN TO TOWN"
	elif battle_state == BATTLE_DEFEAT:
		status_text = "DEFEAT — R RETRY / ESC RETURN TO TOWN"
	elif feedback_timer > 0.0:
		status_text = feedback_text
	elif attack_mode_active and selected_party_index >= 0:
		var selected_attack: Dictionary = party[selected_party_index]["attack"]
		status_text = "%s — SELECT TARGET  /  RMB OR ESC CANCEL  /  WASD MOVE" % String(selected_attack["name"])
	elif _is_party_block() and selected_party_index >= 0:
		var actor_position: Vector2 = party[selected_party_index]["position"]
		status_text = "%s  /  %s  /  F ATTACK  /  LMB OR WASD MOVE  /  TAB SWITCH" % [
			String(party[selected_party_index]["name"]),
			_zone_name(_zone_index(actor_position.x))
		]
	else:
		status_text = "%s — ENEMY ACTIONS RESOLVE SEQUENTIALLY" % _block_name()

	draw_rect(Rect2(126.0, 258.0, 388.0, 14.0), Color(0.88, 0.88, 0.88), true)
	draw_rect(Rect2(126.0, 258.0, 388.0, 14.0), ink, false, 1.0)
	draw_string(font, Vector2(130.0, 268.0), status_text, HORIZONTAL_ALIGNMENT_CENTER, 380.0, 6, ink)


func _draw_party_hud(ink: Color, white: Color, font: Font) -> void:
	draw_rect(Rect2(0.0, HUD_TOP, 640.0, HUD_HEIGHT), Color(0.14, 0.14, 0.14), true)
	var preview = _current_preview()

	for party_index in range(3):
		var panel_rect = _hud_panel_rect(party_index)
		var is_selected = party_index == selected_party_index
		var is_active = party_index in _active_party_indices()
		var is_alive = bool(party[party_index]["alive"])
		var panel_tone = 0.30 if is_selected else (0.22 if is_active else (0.16 if is_alive else 0.10))
		draw_rect(panel_rect, Color(panel_tone, panel_tone, panel_tone), true)
		draw_rect(panel_rect, white if is_selected else Color(0.62, 0.62, 0.62), false, 2.0 if is_selected else 1.0)

		var portrait_rect = Rect2(panel_rect.position + Vector2(6.0, 6.0), Vector2(24.0, 24.0))
		draw_rect(portrait_rect, Color(0.62, 0.62, 0.62), true)
		draw_rect(portrait_rect, white, false, 1.0)
		draw_string(font, portrait_rect.position + Vector2(0.0, 16.0), str(party_index + 1), HORIZONTAL_ALIGNMENT_CENTER, 24.0, 9, ink)

		var name_text = "%s + %s" % [
			String(party[party_index]["name"]),
			_companion_name(String(party[party_index]["companion"]))
		]
		draw_string(font, panel_rect.position + Vector2(36.0, 15.0), name_text, HORIZONTAL_ALIGNMENT_LEFT, 160.0, 8, white)
		_draw_bar(
			_hud_bar_rect(panel_rect, 0),
			float(party[party_index]["hp"]) / float(party[party_index]["max_hp"]),
			HEALTH_COLOR
		)

		var preview_cost = 0.0
		if is_selected and not preview.is_empty() and bool(preview["valid"]) and bool(preview["affordable"]):
			preview_cost = float(preview["cost"])
		_draw_action_bar(
			_hud_bar_rect(panel_rect, 1),
			float(party[party_index]["action_gauge"]),
			preview_cost
		)
		_draw_bar(
			_hud_bar_rect(panel_rect, 2),
			float(party[party_index]["resource_ratio"]),
			_resource_color(String(party[party_index]["resource"]))
		)
		# Slots 3 and 4 remain spatially reserved for two additional inherited
		# class resources. They are not drawn until the character possesses them,
		# preventing an unused slot from resembling an empty active resource.
		var companion_status = "COMPANION ATTACHED" if is_alive else "DEFEATED"
		draw_string(font, panel_rect.position + Vector2(6.0, 74.0), companion_status, HORIZONTAL_ALIGNMENT_LEFT, 188.0, 6, Color(0.72, 0.72, 0.72))


func _hud_panel_rect(party_index: int) -> Rect2:
	return Rect2(4.0 + party_index * 212.0, 278.0, 204.0, 78.0)


func _hud_bar_rect(panel_rect: Rect2, slot_index: int) -> Rect2:
	assert(slot_index >= 0 and slot_index < HUD_BAR_SLOT_COUNT)
	return Rect2(
		panel_rect.position + HUD_BAR_OFFSET + Vector2(0.0, HUD_BAR_STEP_Y * slot_index),
		HUD_BAR_SIZE
	)


func _companion_name(code: String) -> String:
	match code:
		"R":
			return "RAT"
		"D":
			return "MUTT"
		"E":
			return "STORM"
	return "NONE"


func _resource_color(resource_name: String) -> Color:
	match resource_name.to_upper():
		"MANA":
			return MANA_COLOR
		"RAGE":
			return RAGE_COLOR
		"ENERGY":
			return ENERGY_COLOR
		"FAITH":
			return FAITH_COLOR
		"FOCUS":
			return FOCUS_COLOR
		"RESOLVE":
			return RESOLVE_COLOR
		"CORRUPTION", "INSANITY", "WARLOCK":
			return WARLOCK_RESOURCE_COLOR
		"WARDEN":
			return WARDEN_RESOURCE_COLOR
	return Color(0.72, 0.72, 0.72)


func _draw_bar(rect: Rect2, fill_ratio: float, fill_color: Color) -> void:
	draw_rect(rect, BAR_TRACK_COLOR, true)
	var fill_width = rect.size.x * clampf(fill_ratio, 0.0, 1.0)
	if fill_width > 0.0:
		draw_rect(Rect2(rect.position, Vector2(fill_width, rect.size.y)), fill_color, true)
	draw_rect(rect, BAR_BORDER_COLOR, false, 1.0)


func _draw_action_bar(
	rect: Rect2,
	current_gauge: float,
	preview_cost: float
) -> void:
	var current_ratio = clampf(current_gauge / MAX_ACTION_GAUGE, 0.0, 1.0)
	var remaining_gauge = maxf(0.0, current_gauge - preview_cost)
	var remaining_ratio = clampf(remaining_gauge / MAX_ACTION_GAUGE, 0.0, 1.0)

	draw_rect(rect, BAR_TRACK_COLOR, true)
	if current_ratio > 0.0:
		draw_rect(Rect2(rect.position, Vector2(rect.size.x * current_ratio, rect.size.y)), ACTION_GAUGE_COLOR, true)

	if preview_cost > 0.0:
		var preview_start_x = rect.position.x + rect.size.x * remaining_ratio
		var preview_width = rect.size.x * (current_ratio - remaining_ratio)
		var preview_rect = Rect2(preview_start_x, rect.position.y, preview_width, rect.size.y)
		draw_rect(preview_rect, ACTION_GAUGE_COLOR.darkened(0.55), true)

	draw_rect(rect, BAR_BORDER_COLOR, false, 1.0)


func _draw_end_block_confirmation(ink: Color, white: Color, font: Font) -> void:
	var rect = Rect2(164.0, 126.0, 312.0, 68.0)
	draw_rect(rect, Color(0.10, 0.10, 0.10), true)
	draw_rect(rect, white, false, 3.0)
	draw_string(font, rect.position + Vector2(0.0, 24.0), "END THE ENTIRE ALLIED BLOCK?", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 11, white)
	draw_string(font, rect.position + Vector2(0.0, 45.0), "PRESS E / CONFIRM AGAIN    ESC / CLICK: CANCEL", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 7, Color(0.72, 0.72, 0.72))
	draw_string(font, rect.position + Vector2(0.0, 59.0), "ALL REMAINING ACTION GAUGE WILL BE FORFEITED", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 6, Color(0.72, 0.72, 0.72))


func _draw_battle_result(ink: Color, white: Color, font: Font) -> void:
	var rect = Rect2(142.0, 104.0, 356.0, 102.0)
	draw_rect(rect, Color(0.08, 0.08, 0.08), true)
	draw_rect(rect, white, false, 3.0)
	var title = "VICTORY" if battle_state == BATTLE_VICTORY else "DEFEAT"
	var subtitle = "THE COURTYARD IS SECURE" if battle_state == BATTLE_VICTORY else "THE PARTY HAS FALLEN"
	draw_string(font, rect.position + Vector2(0.0, 35.0), title, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 20, white)
	draw_string(font, rect.position + Vector2(0.0, 58.0), subtitle, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 8, Color(0.72, 0.72, 0.72))
	draw_string(font, rect.position + Vector2(0.0, 83.0), "R: RETRY WITH A NEW DEPLOYMENT     ESC: RETURN TO TOWN", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 7, white)
