@tool
extends Control
class_name EditorProp

var hoisted_prop : HoistedProperty
var owning_object : Node

func configure(hoisted_prop : HoistedProperty, owning_object):
	self.hoisted_prop = hoisted_prop
	self.owning_object = owning_object
