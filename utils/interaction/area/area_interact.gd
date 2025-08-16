class_name AreaInteract
extends Area2D

@export var interaction : Interaction

func _ready() -> void:
	
	interaction = interaction.duplicate(true)
	
	interaction.holder = self
	
	
