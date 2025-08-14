class_name RoomEntranceLocations
extends Node

var room : Room
@export var enabled : bool = true

func _ready() -> void:
	if enabled:
		room = get_parent()
		room.teleport_player.connect(on_teleport_player)
	

func on_teleport_player(room_location : SwitchRoomEffect.RoomLocation)->void:
	if enabled:
		for child : RoomEntrance in get_children():
			if child.room_entrance_loc == room_location:
				var player : Player = GlobalVar.player
				player.teleport(child.global_position)
				return
	
	
	if get_child_count() > 0:
		
		var player : Player = GlobalVar.player
		player.teleport(get_child(0).global_position)
	
	
	
	
