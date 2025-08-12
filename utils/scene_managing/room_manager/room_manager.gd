class_name RoomManager
extends Node

var current_room : Room

@export var starting_room_path : StringName


func _ready() -> void:
	GlobalVar.room_manager = self
	
	on_switch_room(load(starting_room_path).instantiate(),SwitchRoomEffect.RoomLocation.WEST)

func on_switch_room(room_scene : Room, room_location : SwitchRoomEffect.RoomLocation )->void:
	var player : Player = GlobalVar.player
	
	
	await get_tree().process_frame
	add_child(room_scene)
	await get_tree().process_frame
	
	
	
	if player.is_inside_tree():
		player.reparent(room_scene)
	
	await get_tree().process_frame
	room_scene.teleport_player.emit(room_location)
	
	
	
	if current_room:
		
		current_room.visible = false
		current_room.call_deferred("queue_free")
	
	current_room = room_scene
	
