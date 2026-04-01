"""
Resource which captures and stores the number of exported buttons
"""

@tool
extends Resource
class_name TheHoist

# Map: String -> HoistedProperty
@export var properties : Dictionary[String, HoistedProperty]
@export var data_map : Dictionary

var test : bool
func _get_property_list() -> Array[Dictionary]:
	var out_properties : Array[Dictionary]
	for prop_id in properties:
		var prop = properties[prop_id]
		out_properties.append(prop.property_data)
		
	return out_properties
	
func _get(property: StringName):
	if property.begins_with("hoist_"):
		if property in data_map:
			return data_map[property]
	
func _set(property: StringName, value):
	if property.begins_with("hoist_"):
		data_map[property] = value
		return true
	return false

## Called when a hoistable property is hoisted/unhoisted
func on_property_toggled(prop : HoistedProperty, toggled : bool):
	if toggled:
		properties[prop.get_id()] = prop
	else:
		properties.erase(prop.get_id())
	
func is_property_hoisted(prop : HoistedProperty):
	return properties.has(prop.get_id())
