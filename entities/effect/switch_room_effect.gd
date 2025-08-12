class_name SwitchRoomEffect
extends Effect

enum RoomLocation {
	WEST,
	EAST,
	NORTH,
	SOUTH,
}

static func switch_room(room_manager : RoomManager, new_room_scene : Room,room_location : SwitchRoomEffect.RoomLocation, previous_room : Room )->void:
	
	previous_room.on_leave_room(new_room_scene,room_location)
	
	room_manager.on_switch_room(new_room_scene,room_location)
	
	await GlobalVar.get_tree().process_frame

static func dialogue_switch_room(new_room_path : StringName, room_location : SwitchRoomEffect.RoomLocation = SwitchRoomEffect.RoomLocation.NORTH)->void:
	
	switch_room(GlobalVar.room_manager,load(new_room_path).instantiate(), room_location,GlobalVar.current_room)
	
	
