class_name SwitchRoomEffect
extends Effect

enum RoomLocation {
	WEST,
	EAST,
	NORTH,
	SOUTH,
}

func switch_room(room_manager : RoomManager, new_room_scene : Room,room_location : SwitchRoomEffect.RoomLocation, previous_room : Room )->void:
	previous_room.on_leave_room(new_room_scene,room_location)
	
	room_manager.on_switch_room(new_room_scene,room_location)
	
