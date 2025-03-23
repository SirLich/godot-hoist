# Hoist

This repository contains an experimental Godot add on for "Hoisting" variables in the inspector.
This is intended as a replacement for the "editable children" workflow.

As I've written this around a year ago, my memory of how it works (and whether it's compatible with 4.4)
is fuzzy. 

I'm publishing it *now*, because I watched an interesting video about _get_property_list, and I want to
see if I can use this knowledge to improve the library.

## Hoisting Variables [ui]

The first aspect of this library is a UI modification of the properties panel, which injects a checkbox
into the inspector, to the left of any hoistable properties. A property is considered hoistable if it
is a direct child or grand-child of a node which contains a hoist. 

## Hoists

To mark a node as containing hoisted properties, simply export TheHoist. For example:
	
@export_category("Hoisted Variables")
@export var hoist : TheHoist
