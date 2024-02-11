"""
The 'HoistInspector' is used to inject the hoist property editor (the property editor in the root).
"""

@tool
extends EditorInspectorPlugin
class_name HoistInspector

func _can_handle(object: Object) -> bool:
	if "hoist" in object:
		return true
	return false

func _parse_end(object: Object) -> void:
	pass
	
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	var inspected_object = object[name]
	if inspected_object is TheHoist:
		for hoisted_property in inspected_object.properties:
			var editor = HoistPropertyEditor.new()
			editor.configure(inspected_object.properties[hoisted_property], object)
			add_custom_control(editor)
		return true
	else:
		return false
		
