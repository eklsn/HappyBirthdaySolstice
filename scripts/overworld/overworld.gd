extends Node2D

@export var overworld : bool = true
@export var fade_in : float = 0.5
@export var fade_out : float = 0.5

func _ready() -> void:
	position = Vector2.ZERO
	if overworld:
		z_index = 999
		
