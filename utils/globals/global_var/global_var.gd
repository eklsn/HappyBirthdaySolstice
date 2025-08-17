extends Node

var player : Player 
var room_manager : RoomManager
var current_room : Room
var plot = 0
var change_outfit : bool = false

var save_data :Dictionary = {}


signal gems_mined
var needed_gems : Array[MiningGem] = []

var mined_gems : Array[MiningGem] = []

var mined_gems_text : String



var mining_meteor : Node2D
func create_home_kinda_2_meteor()->void:
	mining_meteor = load("uid://ro1he0okhemw").instantiate()
	mining_meteor.scale = Vector2(2.0,2.0)
	mining_meteor.global_position = Vector2(300,312)
	current_room.add_child(mining_meteor)
	
	

func play_home_kinda_2_meteor_minigame()->void:
	GlobalVar.plot +=0.001
	var mining_game : MiningMinigameSetup = load("uid://dkdy7tab8dwks").instantiate()
	mining_game.mining_setup = load("uid://ctr0jnnk7fok4")
	Vfx.add_child(mining_game)
	mining_meteor.queue_free()
	
	await mining_game.minigame_finished
	GlobalVar.plot +=-0.001
	DialogueManager.show_dialogue_balloon_scene("uid://dllel4wxacax2",load("uid://cvo6i52us6hwu"))
	
	
	

var home_actually_finished : bool = false
var home_actually_filler_counter : int = 0


var still_hope_rocks_mined : int = 0
