"""
The HoistedPropertyInspector is used to sniff out potentialy hoistable
properties, and provide an editor interface for hoisting them.
"""

@tool
extends EditorInspectorPlugin
class_name HoistedPropertyInspector

func _can_handle(object: Object) -> bool:
	if object is Node and "hoist" in object.owner:
		return true
	return false

class ControlSniffer extends Control:
	var object : Object
	var hoist : TheHoist
	
	func configure(object : Object):
		self.object = object
		self.hoist = object.owner.hoist
		
	func print_recursive(node, depth):
		for child in node.get_children(true):
			print(" ".repeat(depth), child.get_class())
			print_recursive(child, depth + 1)
	
	func inject():
		var debug = true
		for child in get_parent().get_children(true):
			if child.get_class() == "EditorInspectorSection":
				var vbox = child.get_child(0)
				for prop : Control in vbox.get_children():
					var container = HBoxContainer.new()
					var checkbox = PropertyOverrideCheckbox.new()
					container.add_child(checkbox)
					
					checkbox.configure(prop.get_edited_property(), prop.get_edited_object(), hoist)
					
					if debug:
						print(prop)
						print(prop.get_edited_property())
						var edited_prop : Object = prop.get_edited_object()
						print(edited_prop.owner.get_path_to(edited_prop))
						debug = false
					prop.add_sibling(container)
					prop.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					prop.reparent(container)

					
 		
	func _ready() -> void:
		print("----")
		inject()

			
func _parse_end(object: Object):
	var sniffer = ControlSniffer.new()
	sniffer.configure(object)
	add_custom_control(sniffer)
	
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	return false
		
