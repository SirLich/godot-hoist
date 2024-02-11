"""
Resource which captures and stores the number of exported buttons
"""

@tool
extends Resource
class_name TheHoist

@export var num_exported : int
@export var properties : Dictionary
@export var string_id : String

func test():
	print("HELLO WORLD!")
	
func on_property_toggled(prop : HoistedProperty, toggled : bool):
	if toggled:
		properties[prop.property_name] = prop
	else:
		properties.erase(prop.property_name)
		
	print(prop.property_name, " ", str(toggled))
	
func is_property_hoisted(prop : HoistedProperty):
	return properties.has(prop.property_name)
