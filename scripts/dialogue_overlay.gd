extends Control

signal dialogue_closed

const PANEL_HEIGHT := 96.0
const PORTRAIT_FRAME_SIZE := Vector2(72.0, 72.0)

var panel: Panel
var portrait_frame: Panel
var portrait_label: Label
var speaker_label: Label
var dialogue_label: Label
var advance_label: Label


func _ready() -> void:
	position = Vector2.ZERO
	size = Vector2(640.0, 360.0)
	# The town owns dialogue advancement, so the overlay must remain visually
	# present without consuming the click before _unhandled_input receives it.
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	z_index = 100
	_build_interface()
	hide()


func present(speaker: String, line: String, expression: String, has_portrait: bool) -> void:
	speaker_label.text = speaker
	dialogue_label.text = line
	portrait_frame.visible = has_portrait

	if has_portrait:
		portrait_label.text = "PLACEHOLDER\n%s" % expression.to_upper()
		speaker_label.position = Vector2(88.0, 274.0)
		dialogue_label.position = Vector2(88.0, 294.0)
		dialogue_label.size = Vector2(540.0, 48.0)
	else:
		speaker_label.position = Vector2(12.0, 274.0)
		dialogue_label.position = Vector2(12.0, 294.0)
		dialogue_label.size = Vector2(616.0, 48.0)

	show()


func dismiss() -> void:
	hide()
	dialogue_closed.emit()


func _build_interface() -> void:
	panel = Panel.new()
	panel.position = Vector2(0.0, 360.0 - PANEL_HEIGHT)
	panel.size = Vector2(640.0, PANEL_HEIGHT)
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_theme_stylebox_override("panel", _panel_style(Color(0.09, 0.09, 0.09), Color(0.86, 0.86, 0.86), 2))
	add_child(panel)

	portrait_frame = Panel.new()
	portrait_frame.position = Vector2(8.0, 276.0)
	portrait_frame.size = PORTRAIT_FRAME_SIZE
	portrait_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portrait_frame.add_theme_stylebox_override("panel", _panel_style(Color(0.28, 0.28, 0.28), Color(0.92, 0.92, 0.92), 2))
	add_child(portrait_frame)

	portrait_label = Label.new()
	portrait_label.position = Vector2(4.0, 4.0)
	portrait_label.size = Vector2(64.0, 64.0)
	portrait_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	portrait_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	portrait_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portrait_label.add_theme_font_size_override("font_size", 8)
	portrait_label.add_theme_color_override("font_color", Color(0.94, 0.94, 0.94))
	portrait_frame.add_child(portrait_label)

	speaker_label = Label.new()
	speaker_label.position = Vector2(88.0, 274.0)
	speaker_label.size = Vector2(420.0, 18.0)
	speaker_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	speaker_label.add_theme_font_size_override("font_size", 11)
	speaker_label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0))
	add_child(speaker_label)

	dialogue_label = Label.new()
	dialogue_label.position = Vector2(88.0, 294.0)
	dialogue_label.size = Vector2(540.0, 48.0)
	dialogue_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	dialogue_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	dialogue_label.add_theme_font_size_override("font_size", 10)
	dialogue_label.add_theme_color_override("font_color", Color(0.92, 0.92, 0.92))
	add_child(dialogue_label)

	advance_label = Label.new()
	advance_label.position = Vector2(490.0, 342.0)
	advance_label.size = Vector2(138.0, 12.0)
	advance_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	advance_label.text = "CLICK / SPACE: NEXT"
	advance_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	advance_label.add_theme_font_size_override("font_size", 7)
	advance_label.add_theme_color_override("font_color", Color(0.68, 0.68, 0.68))
	add_child(advance_label)


func _panel_style(background: Color, border: Color, width: int) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = background
	style.border_color = border
	style.border_width_left = width
	style.border_width_top = width
	style.border_width_right = width
	style.border_width_bottom = width
	return style
