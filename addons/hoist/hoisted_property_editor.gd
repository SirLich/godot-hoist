"""
The 'HoistInspector' is used to inject the hoist property editor (the property editor in the root).
"""

@tool
extends EditorInspectorPlugin

func _can_handle(object: Object) -> bool:
	if "hoist" in object: ## Not an amazing check...
		return true
	return false

## Whether Hoist can be debugged (resource visible in root). Set via project settings.
func is_debug_hoist() -> bool:
	return false

func prop_changed(property: StringName, value: Variant, field: StringName, changing: bool, object_to_use):
	object_to_use.set(property, value)
	
func get_configured_editor_property(hoisted_prop: HoistedProperty, owning_object):
	var wrapper = VBoxContainer.new() ## I cannot figure out why a wrapper is required..
	
	var data = hoisted_prop.editor_data
	var object_to_use = owning_object.get_node(hoisted_prop.property_path)
	var editor = EditorInspector.instantiate_property_editor(object_to_use, data.type, data.name, data.hint, data.hint_string, data.usage, false)
	editor.label = hoisted_prop.get_id()
	editor.set_object_and_property(object_to_use, data.name)
	editor.update_property()
	editor.property_changed.connect(prop_changed.bind(object_to_use))
	
	wrapper.add_child(editor)
	
	return wrapper
	
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	var inspected_object = object[name]
	if hint_string == "Hoist":
		## Ensure that hoist is created, if null
		if inspected_object == null:
			inspected_object = Hoist.new()
			
			object.set(name, inspected_object)
			object.emit_changed(name, inspected_object)
					
		## We need to force editable children on, or we cannot hoist
		object.get_parent().set_editable_instance(object, true)
		for prop_name in inspected_object.properties:
			var hoisted_property = inspected_object.properties[prop_name]
			
			if !object.has_node(hoisted_property.property_path):
				continue ## A stale hoist -we can skip. If the user re-adds, it will start working again.

			var editor = get_configured_editor_property(hoisted_property, object)
			add_custom_control(editor)
			#add_custom_control(editor) TODO: Not possible due to engine limitation.
		
		print(is_debug_hoist())
		return !is_debug_hoist() # Allows inspection of the 'Hoist' variable
	else:
		return false
