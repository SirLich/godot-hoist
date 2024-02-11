@tool
extends EditorProperty
class_name HoistPropertyEditor

var hoisted_prop : HoistedProperty

func configure(hoisted_prop : HoistedProperty, owning_object : Object):
	self.hoisted_prop = hoisted_prop
	
	if hoisted_prop.property_data.type == TYPE_BOOL:
		var prop = EditorPropCheck.new()
		prop.configure(hoisted_prop, owning_object)
		add_child(prop)
	else:
		pass
	
	
	label = hoisted_prop.property_name
	

