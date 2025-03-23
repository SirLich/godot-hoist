"""
Attempted simplification of Hoist which works on the property list instead.
"""

@tool
extends Resource
class_name SimpleHoist

func _get_property_list() -> Array[Dictionary]:
	return [
		{
			"name": "test",
			"type": TYPE_BOOL,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint_string": "Hello World!"
		}
	]
