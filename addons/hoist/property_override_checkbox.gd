"""
Checkbox which will be instanced into the inspector to the left of hoistable properties.
"""

@tool
extends CheckBox
#class_name PropertyOverrideCheckbox

var hoisted_property : HoistedProperty = HoistedProperty.new()
var hoist : TheHoist

func configure(hoisted_property : HoistedProperty, hoist : TheHoist):
	var margin_container = MarginContainer.new()
	margin_container.add_theme_constant_override("margin_right", -16)
	add_sibling(margin_container)
	reparent(margin_container)
	
	# TODO: Properties using `set_bottom_editor` are miss-aligned, but we cannot detect them easily.
	self.size_flags_vertical= Control.SIZE_FILL
	self.hoisted_property = hoisted_property
	self.hoist = hoist
	set_pressed_no_signal(hoist.is_property_hoisted(hoisted_property))
	toggled.connect(on_toggled)

func on_toggled(toggled):
	hoist.on_property_toggled(hoisted_property, toggled)
