"""
Resource which captures and stores the number of exported buttons
"""

@tool
extends Resource
class_name TheHoist

@export var properties : Dictionary
@export var is_new_asset = true

func _init() -> void:
	for key in properties:
		var value = properties[key]
	if is_new_asset:
		pass
	else:
		pass
		
	is_new_asset = false
	resource_local_to_scene = true
	
func on_property_toggled(prop : HoistedProperty, toggled : bool):
	if toggled:
		properties[prop.property_name] = prop
	else:
		properties.erase(prop.property_name)
		
	print(prop.property_name, " ", str(toggled))
	
func is_property_hoisted(prop : HoistedProperty):
	return properties.has(prop.property_name)
