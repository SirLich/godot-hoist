"""
Property Editor instance, loaded by Hoist.
"""

@tool
extends EditorProperty
class_name HoistPropertyEditor

var hoisted_prop : HoistedProperty

func configure(hoisted_prop : HoistedProperty, owning_object : Object):
	self.hoisted_prop = hoisted_prop
	
	var prop : EditorProp
	if hoisted_prop.property_data.type == TYPE_BOOL:
		prop = EditorPropCheck.new()
	else:
		prop = EditorPropUnsupported.new()

	prop.configure(hoisted_prop, owning_object)
	add_child(prop)
	
	label = hoisted_prop.get_id()
	
