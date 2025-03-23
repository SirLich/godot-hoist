@tool
extends EditorProp
class_name EditorPropUnsupported

func _ready() -> void:
	var label = Label.new()
	label.text = "Property type '{property_type}' is unsupported".format({"property_type": hoisted_prop.property_data.type})
	add_child(label)
