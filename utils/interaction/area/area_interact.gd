class_name AreaInteract
extends Area2D

@export var interaction : Interaction

func _ready() -> void:
	if get_parent() is not Room:
		printerr("Area interaction parent issn't a room")
		return
	
	interaction.room = get_parent()
	
	
