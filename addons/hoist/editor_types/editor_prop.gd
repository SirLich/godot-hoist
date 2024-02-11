@tool
extends Control
class_name EditorProp

var hoisted_prop : HoistedProperty
var owning_object : Node

func configure(hoisted_prop : HoistedProperty, owning_object):
	self.hoisted_prop = hoisted_prop
	self.owning_object = owning_object
	
func set_value(variant):
	owning_object.get_node(hoisted_prop.property_path)[hoisted_prop.property_name] = variant
	
func get_value():
	return owning_object.get_node(hoisted_prop.property_path)[hoisted_prop.property_name]
