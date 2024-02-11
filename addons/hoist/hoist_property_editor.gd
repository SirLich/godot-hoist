
@tool
extends EditorProperty
class_name HoistPropertyEditor

# The main control for editing the property.


var property_control = preload("res://addons/hoist/hoist_property_editor.tscn").instantiate()
var current_value = ""
var updating = false

func _init():
	custom_minimum_size.y = 200
	add_child(property_control)
	#set_bottom_editor(property_control)
	property_control
	add_focusable(property_control)
	refresh_control_text()

#func _update_property():
	## Read the current value from the property.
	#var new_value = get_edited_object()[get_edited_property()]
	#if (new_value == current_value):
		#return
#
	## Update the control with the new value.
	#updating = true
	#current_value = new_value
	#refresh_control_text()
	#updating = false

func refresh_control_text():
	property_control.text = "Property Hoisted\n\n\nerew"
