#"""
#Contains the local-to-scene data for a HoistedProperty. Used so that newly
#overriden properties from the base class can propogate, but without carrying 
#incorrect information forward (e.g., the path)
#"""

@tool
extends Resource
class_name HoistedPropertyCache

@export var value_wrapper : Dictionary

func _init() -> void:
	resource_local_to_scene = true
	
	self.value_wrapper = {
		"inner": null
	}
