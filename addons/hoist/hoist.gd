"""
Root plugin file.
"""

@tool
extends EditorPlugin

var hoist_inspector
var hoisted_property_inspector

func _enter_tree() -> void:
	hoist_inspector = HoistInspector.new()
	hoisted_property_inspector = HoistedPropertyInspector.new()
	add_inspector_plugin(hoist_inspector)
	add_inspector_plugin(hoisted_property_inspector)

func _exit_tree() -> void:
	remove_inspector_plugin(hoist_inspector)
	remove_inspector_plugin(hoisted_property_inspector)
