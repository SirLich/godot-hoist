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
	
	func inject():
		
		## Loop over all children of the node within which TheHoist exists.
		## TODO: Add grand-children support?
		for child in get_parent().get_children(true):
			if child.get_class() == "EditorInspectorSection":
				var vbox = child.get_child(0)
				for prop : EditorProperty in vbox.get_children():
					
					var hoisted_property = HoistedProperty.new()
					hoisted_property.configure(prop)
					
					if not hoisted_property.is_valid():
						continue
						
					var container = HBoxContainer.new()
					var checkbox = PropertyOverrideCheckbox.new()
					container.add_child(checkbox)
					
					checkbox.configure(hoisted_property, hoist)
					
					prop.add_sibling(container)
					prop.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					prop.reparent(container)

	func _ready() -> void:
		inject()

func _parse_end(object: Object):
	var sniffer = ControlSniffer.new()
	sniffer.configure(object)
	add_custom_control(sniffer)
