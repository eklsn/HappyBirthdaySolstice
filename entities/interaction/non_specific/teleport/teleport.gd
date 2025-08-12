class_name SwitchRoomInteraction
extends Interaction

@export var room_path : StringName 
@export var room_entrance_loc : SwitchRoomEffect.RoomLocation


const ROOM_TRANS_ANIM : PackedScene = preload("uid://dsvfi24mts60i")

func interact()->void:
	if not room_path:
		printerr("switch room interaction: no room path defined")
		return
	if not room || not room.room_manager:
		printerr("switch room interaction: no room manager")
		return
	
	
	var tree : SceneTree = Vfx.get_tree()
	var room_trans : ColorRect= ROOM_TRANS_ANIM.instantiate()
	
	var player :Player = GlobalVar.player
	player.set_idle(true)
	Vfx.add_child(room_trans)
	await tree.process_frame
	
	room_trans.fade_in()
	
	var loaded_room : Room = ResourceLoader.load(room_path).instantiate()
	await room_trans.animation_finished
	
	SwitchRoomEffect.new().switch_room(room.room_manager,loaded_room,room_entrance_loc,room)
	
	await room_trans.fade_out()
	
	player.set_idle(false)
