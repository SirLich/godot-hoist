"""
Resource which captures and stores the number of exported buttons
"""

@tool
extends Resource
class_name TheHoist

# Map: String -> HoistedProperty
@export var properties : Dictionary[String, HoistedProperty]
var editor_properties : Array[EditorProperty]

var test : bool
func _get_property_list() -> Array[Dictionary]:
	var out_properties : Array[Dictionary]
	for prop_id in properties:
		var prop = properties[prop_id]
		out_properties.append(prop.property_data)
		
	return out_properties
	
func _get(property):
	pass

func _set(property, value):
	pass

func on_property_toggled(prop : HoistedProperty, toggled : bool):
	if toggled:
		properties[prop.get_id()] = prop
	else:
		properties.erase(prop.get_id())
	
func is_property_hoisted(prop : HoistedProperty):
	return properties.has(prop.get_id())
