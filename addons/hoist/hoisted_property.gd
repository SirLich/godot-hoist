@tool
extends Resource
class_name HoistedProperty 

# Serialized Fields
@export var property_name : String
@export var property_path : NodePath
@export var property_data : Dictionary

var valid_types = [
	TYPE_BOOL
]

func _get_property(prop, name):
	for p in prop.get_property_list():
		if p.name == name:
			return p
	return null
		
func configure(prop : EditorProperty):
	var edited_prop : Object = prop.get_edited_object()
	var path = edited_prop.owner.get_path_to(edited_prop)
	self.property_name = prop.get_edited_property()
	self.property_path = path
	self.property_data = _get_property(prop.get_edited_object(), prop.get_edited_property())
	
func is_valid() -> bool:
	return property_data.type in valid_types
	


