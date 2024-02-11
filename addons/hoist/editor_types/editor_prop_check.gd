@tool
extends EditorProp
class_name EditorPropCheck

func on_toggled(new_value):
	set_value(new_value)
	
func _ready() -> void:
	var checkbox = CheckBox.new()
	checkbox.set_pressed_no_signal(get_value())
	checkbox.toggled.connect(on_toggled)
	
	add_child(checkbox)
