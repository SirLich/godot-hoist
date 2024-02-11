"""
Resource which captures and stores the number of exported buttons
"""

@tool
extends Resource
class_name TheHoist

# Map: String -> HoistedProperty
@export var properties : Dictionary
@export var is_new_asset : bool

func _init() -> void:
	resource_local_to_scene = true
	
func refresh() -> void:
	print("Initing TheHoist!")
	for key in properties:
		var hoisted_property : HoistedProperty = properties[key]
		hoisted_property.refresh_value(is_new_asset)

	is_new_asset = false

	
func _notification(type):
	if type == NOTIFICATION_POSTINITIALIZE:
		print("POST INIT")

func on_property_toggled(prop : HoistedProperty, toggled : bool):
	if toggled:
		properties[prop.property_name] = prop
	else:
		properties.erase(prop.property_name)
		
	print(prop.property_name, " ", str(toggled))
	
func is_property_hoisted(prop : HoistedProperty):
	return properties.has(prop.property_name)
