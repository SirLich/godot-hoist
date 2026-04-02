"""
Used to sniff out potentialy hoistable
properties, and provide an editor interface for hoisting them.
"""

@tool
extends EditorInspectorPlugin

const PropertyOverrideCheckbox = preload("uid://bbwdbh4ceadf3")

func _can_handle(object: Object) -> bool:
	if object is Node and object.owner != null and "hoist" in object.owner:
		return true
	return false

#func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	#return false
	
class ControlSniffer extends Control:
	var object : Object
	var hoist : Hoist
	
	func get_children_recursive(parent: Node) -> Array[Node]:
		var result: Array[Node] = []
		var stack: Array[Node] = [parent]

		while not stack.is_empty():
			var current: Node = stack.pop_back()
			for child in current.get_children():
				result.append(child)
				stack.append(child)
		
		return result
	
	func get_children_by_type(node : Node, type):
		var children = []
		for child in get_children_recursive(node):
			if is_instance_of(child, type):
				children.append(child)
		return children
	
	func configure(object : Object):
		self.object = object
		self.hoist = object.owner.hoist
	
	func inject():
		var children = get_children_by_type(get_parent(), EditorProperty)
		for prop in children:
			var editor_property = prop as EditorProperty
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
