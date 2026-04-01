"""
Property Editor instance, loaded by Hoist.
"""

@tool
extends EditorProperty
class_name HoistPropertyEditor

var hoisted_prop : HoistedProperty

func configure(hoisted_prop : HoistedProperty, owning_object : Object):
	set_anchors_and_offsets_preset(PRESET_CENTER_LEFT)
	self.hoisted_prop = hoisted_prop
			
	var data = hoisted_prop.editor_data
	var object_to_use = owning_object.get_node(hoisted_prop.property_path)
	var editor = EditorInspector.instantiate_property_editor(object_to_use, data.type, data.name, data.hint, data.hint_string, data.usage, false)
	editor.set_anchors_and_offsets_preset(PRESET_CENTER_LEFT)
	editor.set_object_and_property(object_to_use, data.name)
	editor.update_property()
	
	add_child(editor)
	
	label = hoisted_prop.get_id()
	
