@tool
extends CheckBox
class_name PropertyOverrideCheckbox

var hoisted_property : HoistedProperty = HoistedProperty.new()
var hoist : TheHoist
	
func configure(hoisted_property : HoistedProperty, hoist : TheHoist):
	self.hoisted_property = hoisted_property	
	self.hoist = hoist
	set_pressed_no_signal(hoist.is_property_hoisted(hoisted_property))
	
	size_flags_vertical = SIZE_SHRINK_BEGIN

func on_toggled(toggled):
	hoist.on_property_toggled(hoisted_property, toggled)


func _ready() -> void:
	toggled.connect(on_toggled)
