"""
Structure that wraps a property that is being hoisted. For example if you turn on 
hoisting for Node2D::Visible, this HoistedProperty captures that relationship.
"""

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

## The data (Like that returned from _get_property_list)
@export var editor_data : Dictionary
	
# Transient Fields
var owning_object : Node

func get_id():
	return str(property_path) + ":" + property_name
	
func set_value(variant):
	owning_object.get_node(property_path)[property_name] = variant
	
func get_value():
	return owning_object.get_node(property_path)[property_name]

func _get_property(prop : Object, name):
	for p in prop.get_property_list():
		if p.name == name:
			var new_property_data = p
			new_property_data.name = "hoist_" + new_property_data.name
			return new_property_data
	return null

## Like _get_property_list but for just a single property.
func get_property_info(object, property_name: String) -> Dictionary:
	for prop in object.get_property_list():
		if prop.name == property_name:
			return prop
	return {}
	
func configure(prop : EditorProperty):
	var edited_prop : Object = prop.get_edited_object()
	var path = edited_prop.owner.get_path_to(edited_prop)
	self.property_name = prop.get_edited_property()
	self.property_path = path
	self.editor_data = get_property_info(edited_prop, self.property_name)
	self.property_data = _get_property(prop.get_edited_object(), prop.get_edited_property())
	
	
func is_valid() -> bool:
	return true
	
	#var is_valid_type = property_data.type in VALID_TYPES
	#
	#return is_valid_type
	#var is_instanced_scene = owning_object.owner == owning_object.get_tree().edited_scene_root
	#
	#return is_valid_type and not is_instanced_scene
	
