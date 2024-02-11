"""
The 'HoistInspector' is used to inject the hoist property editor (the property editor in the root).
"""

@tool
extends EditorInspectorPlugin
class_name HoistInspector

func _can_handle(object: Object) -> bool:
	return false
	if "hoist" in object:
		return true
	return false
	
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	var inspected_object = object[name]
	if inspected_object is TheHoist:
		add_property_editor(name, HoistPropertyEditor.new())
		return true
	else:
		return false
		
