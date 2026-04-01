"""
The 'HoistInspector' is used to inject the hoist property editor (the property editor in the root).
"""

@tool
extends EditorInspectorPlugin
class_name HoistInspector

func _can_handle(object: Object) -> bool:
	if "hoist" in object and object.hoist is TheHoist:
		return true
	return false

## Whether Hoist can be debugged (resource visible in root). Set via project settings.
func is_debug_hoist() -> bool:
	var hoist_path = "editor/hoist/debug"
	if not ProjectSettings.has_setting(hoist_path):
		ProjectSettings.set_setting(hoist_path, false)
	return ProjectSettings.get_setting(hoist_path, false)

func get_my_property(hoisted_prop, owning_object):
	var data = hoisted_prop.property_data
	var object_to_use = owning_object.get_node(hoisted_prop.property_path)
	var editor = EditorInspector.instantiate_property_editor(object_to_use, data.type, data.name, data.hint, data.hint_string, data.usage, false)
	editor.set_object_and_property(object_to_use, data.name)
	editor.update_property()
	return editor
	
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	var inspected_object = object[name]
	if inspected_object is TheHoist:
		
		## Whether to force editable children on.
		#object.get_parent().set_editable_instance(object, true)
		for prop_name in inspected_object.properties:
			var hoisted_property = inspected_object.properties[prop_name]

			#var editor = get_my_property(hoisted_property, object)
			var editor = HoistPropertyEditor.new()
			editor.configure(hoisted_property, object)
			
			
			add_custom_control(editor)
			#add_property_editor(hoisted_property.property_name, editor, true, "Baba")
			editor.update_property()


		return !is_debug_hoist() # Allows inspection of the 'Hoist' variable
	else:
		return false
		
		
