class_name Room
extends Node2D


signal saving_room(room_save_info : Dictionary)
signal loading_room(room_save_info : Dictionary)

signal teleport_player(room_location : SwitchRoomEffect.RoomLocation)

@export var camera_limit_left : int = -10000000
@export var camera_limit_top : int = -10000000
@export var camera_limit_right : int = 10000000

@export var camera_limit_bottom : int = 10000000

var room_manager : RoomManager

func _ready() -> void:
	GlobalVar.current_room = self
	
	
	
	if get_viewport().get_camera_2d():
		get_viewport().get_camera_2d().limit_bottom = camera_limit_bottom
		get_viewport().get_camera_2d().limit_top = camera_limit_top
		get_viewport().get_camera_2d().limit_right = camera_limit_right
		get_viewport().get_camera_2d().limit_left = camera_limit_left
		
	
	
	
	
	if not get_parent() || not get_parent() is RoomManager:
		return
	
	
	room_manager = get_parent()
	load_room()
	






func on_leave_room(_new_room_scene : Room, _new_room_location : SwitchRoomEffect.RoomLocation)->void:
	save_room()
	





func save_room()->void:
	var room_save_info : Dictionary = {}
	
	saving_room.emit(room_save_info)
	
	GlobalVar.save_data.set(ResourceLoader.get_resource_uid(self.scene_file_path),room_save_info)
	

func load_room()->void:
	
	if !GlobalVar.save_data.has(ResourceLoader.get_resource_uid(self.scene_file_path)):
		on_enter_room()
		return
	
	
	
	var room_save_info : Dictionary = GlobalVar.save_data.get(ResourceLoader.get_resource_uid(self.scene_file_path))
	
	
	loading_room.emit(room_save_info)
	
	on_enter_room()
	

func on_enter_room()->void:
	pass
