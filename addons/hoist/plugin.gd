@tool
extends EditorPlugin

const HoistedPropertyEditor = preload("uid://c6qma3xbbr10m")
const HoistCheckboxInjector = preload("uid://de6rtci57vcm7")

var hoisted_property_editor
var hoist_checkbox_injector

func _enter_tree() -> void:
	hoisted_property_editor = HoistedPropertyEditor.new()
	hoist_checkbox_injector = HoistCheckboxInjector.new()
	
	add_inspector_plugin(hoisted_property_editor)
	add_inspector_plugin(hoist_checkbox_injector)

func _exit_tree() -> void:
	remove_inspector_plugin(hoisted_property_editor)
	remove_inspector_plugin(hoist_checkbox_injector)
