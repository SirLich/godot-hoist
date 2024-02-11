@tool

extends Node2D

@export_category("Hoisted Variables")
@export var hoist : TheHoist

func _ready() -> void:
	await get_tree().create_timer(1).timeout # TODO: This is dumb, ofc.
	print("refreshing...")
	hoist.refresh()
