extends Node

const TownSquareScript = preload("res://scripts/town_square.gd")
const BattleShellScript = preload("res://scripts/battle_shell.gd")

var active_scene: Node
var transition_pending := false


func _ready() -> void:
	get_window().min_size = Vector2i(640, 360)
	_show_town()


func _show_town() -> void:
	if transition_pending:
		return
	transition_pending = true
	call_deferred("_replace_with_town")


func _replace_with_town() -> void:
	var town = TownSquareScript.new()
	town.battle_requested.connect(_show_battle)
	_replace_active_scene(town)
	transition_pending = false


func _show_battle() -> void:
	if transition_pending:
		return
	transition_pending = true
	call_deferred("_replace_with_battle")


func _replace_with_battle() -> void:
	var battle = BattleShellScript.new()
	battle.return_requested.connect(_show_town)
	_replace_active_scene(battle)
	transition_pending = false


func _replace_active_scene(next_scene: Node) -> void:
	if is_instance_valid(active_scene):
		remove_child(active_scene)
		active_scene.queue_free()

	active_scene = next_scene
	add_child(active_scene)
