@tool

extends Node2D

@export var my_own_var : int

@export_category("Hoisted Variables")
@export var hoist : TheHoist
func _get_property_list() -> Array[Dictionary]: return hoist._get_property_list()
