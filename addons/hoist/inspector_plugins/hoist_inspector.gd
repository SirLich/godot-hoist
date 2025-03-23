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

func is_debug_hoist() -> bool:
	var hoist_path = "editor/hoist/debug"
	if not ProjectSettings.has_setting(hoist_path):
		ProjectSettings.set_setting(hoist_path, false)
	return ProjectSettings.get_setting(hoist_path, false)

func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	var inspected_object = object[name]
	if inspected_object is TheHoist:
		object.get_parent().set_editable_instance(object, true)
		for prop_name in inspected_object.properties:
			var editor = HoistPropertyEditor.new()
			editor.configure(inspected_object.properties[prop_name], object)
			add_custom_control(editor)
		return !is_debug_hoist() # Allows inspection of the 'Hoist' variable
	else:
		return false
		
