@tool
extends Resource
class_name HoistedProperty

# Serialized Fields
@export var property_name : String
@export var property_path : NodePath
@export var property_data : Dictionary
@export var value_wrapper : Dictionary

# Transient Fields
var owning_object

var valid_types = [
	TYPE_BOOL
]

func set_value(variant):
	print("SetValue called: ", property_name, " ", variant)
	value_wrapper.inner = variant
	owning_object.get_node(property_path)[property_name] = variant
	
func get_value():
	var ret = owning_object.get_node(property_path)[property_name]
	print("GetValue called: ", property_name, " ", ret)
	return ret
	
# Refreshes the value from serialized data
func refresh_value(is_new_asset):
	print("Refreshing ", is_new_asset)
	# If the asset is newly created, we should 
	if is_new_asset:
		get_value() # Not really needed
	else:
		set_value(value_wrapper.inner) # Re-serialize from the saved field

func _get_property(prop, name):
	for p in prop.get_property_list():
		if p.name == name:
			return p
	return null

func configure_owning_object(owner):
	self.owning_object = owner
	
func configure(prop : EditorProperty):
	var edited_prop : Object = prop.get_edited_object()
	var path = edited_prop.owner.get_path_to(edited_prop)
	self.value_wrapper = {
		"inner": null
	}
	self.property_name = prop.get_edited_property()
	self.property_path = path
	self.property_data = _get_property(prop.get_edited_object(), prop.get_edited_property())
	
func is_valid() -> bool:
	return property_data.type in valid_types
	


