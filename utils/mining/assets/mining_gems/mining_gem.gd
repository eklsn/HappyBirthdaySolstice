class_name MiningGem
extends Resource

var gem_shape : Array[Vector2i]

var gem_tile_map_positions : Array[Vector2i]

@export var gem_name : StringName = ""

@export var gem_value : float

## Key is gem shape. Value is the position where it gets mapped to in the tile set
@export var gem_shape_tile_map_pos_dict : Dictionary[Vector2i,Vector2i]
