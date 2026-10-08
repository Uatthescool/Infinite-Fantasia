extends Node2D

signal battle_requested

const DialogueOverlayScript = preload("res://scripts/dialogue_overlay.gd")

const CANVAS_SIZE := Vector2(640.0, 360.0)
const PLAYER_HALF_SIZE := Vector2(8.0, 10.0)
const PLAY_BOUNDS := Rect2(8.0, 32.0, 624.0, 294.0)
const BATTLE_GATE := Rect2(566.0, 116.0, 54.0, 94.0)
const NOTICE_BOARD := Rect2(372.0, 154.0, 22.0, 30.0)
const MOVE_SPEED := 118.0

var player_position := Vector2(112.0, 242.0)
var target_position := Vector2(112.0, 242.0)
var last_move_direction := Vector2.RIGHT
var moving_to_target := false
var transition_started := false
var obstacles: Array[Rect2] = []

var dialogue_overlay
var dialogue_open := false
var dialogue_index := 0
var dialogue_lines := [
	{
		"speaker": "ALLY A",
		"expression": "Neutral",
		"portrait": true,
		"line": "The portrait occupies its reserved 64 by 64 space. No finished character art is required."
	},
	{
		"speaker": "YOU",
		"expression": "",
		"portrait": false,
		"line": "The protagonist receives dialogue space without an authored emotional portrait."
	},
	{
		"speaker": "ALLY B",
		"expression": "Surprised",
		"portrait": true,
		"line": "Speaker and expression changes reuse the same fixed left-side portrait slot."
	}
]


func _ready() -> void:
	obstacles = [
		Rect2(24.0, 52.0, 148.0, 82.0),
		Rect2(226.0, 42.0, 126.0, 78.0),
		Rect2(414.0, 52.0, 126.0, 82.0),
		Rect2(276.0, 178.0, 92.0, 56.0),
		Rect2(86.0, 286.0, 96.0, 30.0),
		Rect2(438.0, 278.0, 86.0, 38.0)
	]

	dialogue_overlay = DialogueOverlayScript.new()
	add_child(dialogue_overlay)
	queue_redraw()


func _process(delta: float) -> void:
	if dialogue_open or transition_started:
		return

	var keyboard_direction = _keyboard_direction()
	if keyboard_direction != Vector2.ZERO:
		moving_to_target = false
		last_move_direction = keyboard_direction.normalized()
		_move_player(last_move_direction * MOVE_SPEED * delta)
	elif moving_to_target:
		var to_target = target_position - player_position
		if to_target.length() <= 2.0:
			moving_to_target = false
		else:
			last_move_direction = to_target.normalized()
			var distance = minf(MOVE_SPEED * delta, to_target.length())
			var previous_position = player_position
			_move_player(last_move_direction * distance)
			if player_position.is_equal_approx(previous_position):
				moving_to_target = false

	if _player_rect(player_position).intersects(BATTLE_GATE):
		transition_started = true
		battle_requested.emit()
		return

	queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if dialogue_open:
		if _is_advance_event(event):
			_advance_dialogue()
			get_viewport().set_input_as_handled()
		elif event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
			_close_dialogue()
			get_viewport().set_input_as_handled()
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if NOTICE_BOARD.has_point(event.position) and _is_near_notice_board():
			_start_dialogue()
		else:
			target_position = _clamp_target(event.position)
			moving_to_target = true
		queue_redraw()
		get_viewport().set_input_as_handled()
		return

	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E or event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
			if _is_near_notice_board():
				_start_dialogue()
				get_viewport().set_input_as_handled()
		elif event.keycode == KEY_ESCAPE:
			get_tree().quit()


func _draw() -> void:
	var ink = Color(0.14, 0.14, 0.14)
	var dark = Color(0.24, 0.24, 0.24)
	var middle = Color(0.54, 0.54, 0.54)
	var light = Color(0.82, 0.82, 0.82)
	var paper = Color(0.91, 0.91, 0.91)
	var font = ThemeDB.fallback_font

	draw_rect(Rect2(Vector2.ZERO, CANVAS_SIZE), paper, true)
	draw_rect(Rect2(0.0, 0.0, 640.0, 30.0), ink, true)
	draw_string(font, Vector2(10.0, 20.0), "INFINITE FANTASIA  /  TOWN SQUARE GREYBOX", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 11, Color.WHITE)

	# Walkable square and simple paving guides.
	draw_rect(Rect2(8.0, 32.0, 624.0, 294.0), light, true)
	for x in range(8, 633, 32):
		draw_line(Vector2(x, 32.0), Vector2(x, 326.0), Color(0.75, 0.75, 0.75), 1.0)
	for y in range(32, 327, 32):
		draw_line(Vector2(8.0, y), Vector2(632.0, y), Color(0.75, 0.75, 0.75), 1.0)

	_draw_building(Rect2(24.0, 52.0, 148.0, 82.0), "BUILDING A", dark, paper, ink)
	_draw_building(Rect2(226.0, 42.0, 126.0, 78.0), "CHAPEL", dark, paper, ink)
	_draw_building(Rect2(414.0, 52.0, 126.0, 82.0), "BUILDING B", dark, paper, ink)
	_draw_building(Rect2(86.0, 286.0, 96.0, 30.0), "STALL", middle, paper, ink)
	_draw_building(Rect2(438.0, 278.0, 86.0, 38.0), "ALLEY BLOCK", middle, paper, ink)

	# Central obstacle / future landmark.
	draw_rect(Rect2(276.0, 178.0, 92.0, 56.0), Color(0.66, 0.66, 0.66), true)
	draw_rect(Rect2(276.0, 178.0, 92.0, 56.0), ink, false, 2.0)
	draw_string(font, Vector2(294.0, 210.0), "FOUNTAIN", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 8, ink)

	# Dialogue test marker.
	draw_rect(NOTICE_BOARD, Color(0.36, 0.36, 0.36), true)
	draw_rect(NOTICE_BOARD, ink, false, 2.0)
	draw_string(font, Vector2(377.0, 174.0), "!", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 12, Color.WHITE)
	draw_string(font, Vector2(351.0, 198.0), "DIALOGUE TEST", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 7, ink)

	# Courtyard transition.
	draw_rect(BATTLE_GATE, Color(0.18, 0.18, 0.18), true)
	draw_rect(BATTLE_GATE, Color.WHITE, false, 2.0)
	for y in range(124, 207, 12):
		draw_line(Vector2(570.0, y), Vector2(616.0, y), Color(0.56, 0.56, 0.56), 1.0)
	draw_string(font, Vector2(568.0, 107.0), "COURTYARD", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 8, ink)
	draw_string(font, Vector2(578.0, 224.0), "BATTLE", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 8, ink)

	# Click destination.
	if moving_to_target:
		draw_circle(target_position, 5.0, Color(0.25, 0.25, 0.25), false, 1.0)
		draw_line(target_position - Vector2(7.0, 0.0), target_position + Vector2(7.0, 0.0), ink, 1.0)
		draw_line(target_position - Vector2(0.0, 7.0), target_position + Vector2(0.0, 7.0), ink, 1.0)

	_draw_party_hitboxes(ink)

	draw_rect(Rect2(0.0, 328.0, 640.0, 32.0), ink, true)
	draw_string(font, Vector2(10.0, 347.0), "LMB: MOVE   WASD/ARROWS: MOVE   E/SPACE: INTERACT   ESC: QUIT", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 9, Color.WHITE)

	var notice_hint = "INTERACT AVAILABLE" if _is_near_notice_board() else ""
	draw_string(font, Vector2(500.0, 347.0), notice_hint, HORIZONTAL_ALIGNMENT_RIGHT, 128.0, 8, Color(0.78, 0.78, 0.78))


func _draw_building(rect: Rect2, label_text: String, fill: Color, text_color: Color, border: Color) -> void:
	draw_rect(rect, fill, true)
	draw_rect(rect, border, false, 2.0)
	draw_string(ThemeDB.fallback_font, rect.position + Vector2(8.0, 20.0), label_text, HORIZONTAL_ALIGNMENT_LEFT, rect.size.x - 16.0, 9, text_color)


func _draw_party_hitboxes(ink: Color) -> void:
	var lead_rect = Rect2(player_position - PLAYER_HALF_SIZE, PLAYER_HALF_SIZE * 2.0)
	draw_rect(lead_rect, Color(0.94, 0.94, 0.94), true)
	draw_rect(lead_rect, ink, false, 2.0)
	draw_string(ThemeDB.fallback_font, player_position + Vector2(-5.0, 3.0), "P1", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 7, ink)

	var trail_direction = -last_move_direction
	if trail_direction == Vector2.ZERO:
		trail_direction = Vector2.LEFT
	var side = Vector2(-trail_direction.y, trail_direction.x)
	var follower_a = player_position + trail_direction * 17.0 + side * 7.0
	var follower_b = player_position + trail_direction * 31.0 - side * 7.0
	_draw_follower(follower_a, "P2", ink)
	_draw_follower(follower_b, "P3", ink)


func _draw_follower(position_value: Vector2, label_text: String, ink: Color) -> void:
	var rect = Rect2(position_value - Vector2(6.0, 8.0), Vector2(12.0, 16.0))
	draw_rect(rect, Color(0.72, 0.72, 0.72), true)
	draw_rect(rect, ink, false, 1.0)
	draw_string(ThemeDB.fallback_font, position_value + Vector2(-5.0, 3.0), label_text, HORIZONTAL_ALIGNMENT_LEFT, -1.0, 6, ink)


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


func _move_player(motion: Vector2) -> void:
	var next_x = Vector2(player_position.x + motion.x, player_position.y)
	next_x = _clamp_target(next_x)
	if not _collides_with_obstacle(_player_rect(next_x)):
		player_position.x = next_x.x

	var next_y = Vector2(player_position.x, player_position.y + motion.y)
	next_y = _clamp_target(next_y)
	if not _collides_with_obstacle(_player_rect(next_y)):
		player_position.y = next_y.y


func _clamp_target(value: Vector2) -> Vector2:
	return Vector2(
		clampf(value.x, PLAY_BOUNDS.position.x + PLAYER_HALF_SIZE.x, PLAY_BOUNDS.end.x - PLAYER_HALF_SIZE.x),
		clampf(value.y, PLAY_BOUNDS.position.y + PLAYER_HALF_SIZE.y, PLAY_BOUNDS.end.y - PLAYER_HALF_SIZE.y)
	)


func _player_rect(at_position: Vector2) -> Rect2:
	return Rect2(at_position - PLAYER_HALF_SIZE, PLAYER_HALF_SIZE * 2.0)


func _collides_with_obstacle(rect: Rect2) -> bool:
	for obstacle in obstacles:
		if rect.intersects(obstacle):
			return true
	return false


func _is_near_notice_board() -> bool:
	return player_position.distance_to(NOTICE_BOARD.get_center()) <= 52.0


func _start_dialogue() -> void:
	dialogue_open = true
	dialogue_index = 0
	moving_to_target = false
	_show_dialogue_line()


func _advance_dialogue() -> void:
	dialogue_index += 1
	if dialogue_index >= dialogue_lines.size():
		_close_dialogue()
	else:
		_show_dialogue_line()


func _show_dialogue_line() -> void:
	var entry: Dictionary = dialogue_lines[dialogue_index]
	dialogue_overlay.present(
		entry["speaker"],
		entry["line"],
		entry["expression"],
		entry["portrait"]
	)


func _close_dialogue() -> void:
	dialogue_open = false
	dialogue_overlay.dismiss()


func _is_advance_event(event: InputEvent) -> bool:
	if event is InputEventMouseButton:
		return event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	if event is InputEventKey:
		return event.pressed and not event.echo and (event.keycode == KEY_E or event.keycode == KEY_SPACE or event.keycode == KEY_ENTER)
	return false
