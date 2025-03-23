"""
Resource which captures and stores the number of exported buttons
"""

@tool
extends Resource
class_name TheHoist

# Map: String -> HoistedProperty
@export var properties : Dictionary

func on_property_toggled(prop : HoistedProperty, toggled : bool):
	if toggled:
		properties[prop.get_id()] = prop
	else:
		properties.erase(prop.get_id())
	
func is_property_hoisted(prop : HoistedProperty):
	return properties.has(prop.get_id())
