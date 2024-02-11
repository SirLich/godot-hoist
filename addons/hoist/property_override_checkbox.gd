@tool
extends CheckBox
class_name PropertyOverrideCheckbox

var hoisted_property : HoistedProperty = HoistedProperty.new()
var property : Object
var hoist : TheHoist

func configure(property_name : StringName, property : Object, hoist : TheHoist):
	hoisted_property = hoisted_property.duplicate()
	hoisted_property.property_name = property_name
	
	self.property = property
	self.hoist = hoist
	set_pressed_no_signal(hoist.is_property_hoisted(hoisted_property))

func on_toggled(toggled):
	hoist.on_property_toggled(hoisted_property, toggled)
	
func _ready() -> void:
	toggled.connect(on_toggled)
