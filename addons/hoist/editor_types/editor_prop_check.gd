@tool
extends EditorProp
class_name EditorPropCheck

func on_toggled(new_value):
	hoisted_prop.set_value(new_value)
	
func _ready() -> void:
	var checkbox = CheckBox.new()
	checkbox.set_pressed_no_signal(hoisted_prop.get_value())
	checkbox.toggled.connect(on_toggled)
	
	add_child(checkbox)
