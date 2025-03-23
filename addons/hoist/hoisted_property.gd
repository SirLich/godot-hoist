@tool
extends Resource
class_name HoistedProperty

# Hard coded
var VALID_TYPES = [
	TYPE_BOOL
]

# Serialized Fields
@export var property_name : String
@export var property_path : NodePath
@export var property_data : Dictionary

# Transient Fields
var owning_object : Node

func get_id():
	return str(property_path) + ":" + property_name
	
func set_value(variant):
	owning_object.get_node(property_path)[property_name] = variant
	
func get_value():
	return owning_object.get_node(property_path)[property_name]

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
	var is_valid_type = property_data.type in VALID_TYPES
	
	return is_valid_type
	#var is_instanced_scene = owning_object.owner == owning_object.get_tree().edited_scene_root
	#
	#return is_valid_type and not is_instanced_scene
	
