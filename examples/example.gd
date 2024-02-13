@tool

extends Node2D

@export_category("Hoisted Variables")
@export var hoist : TheHoist

func _enter_tree() -> void:
	await get_tree().create_timer(1).timeout # TODO: This is dumb, ofc.
	print("refreshing...")
	hoist.refresh()
