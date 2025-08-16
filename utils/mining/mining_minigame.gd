class_name MiningMinigameSetup
extends Node

const MAIN_TEXTBOX : PackedScene = preload("uid://dllel4wxacax2")
const MINING_DIALOGUE_END : Resource = preload("uid://c4xwdme27roj")

@onready var mining_gameplay: MiningGameplay = $MiningGameplay

@export var mining_setup : MiningSetup

func _ready() -> void:
	var mining_unique_gems : Array[MiningGem] = []
	mining_unique_gems.assign(mining_setup.mining_gems)
	
	var unique_gems : Array[MiningGem] = []
	for gem in mining_unique_gems:
		if gem not in unique_gems:
			
			unique_gems.append(gem)
	
	mining_unique_gems = unique_gems
	
	#
	#
	#mining_gameplay.mining_gems = mining_setup.mining_gems
	#mining_gameplay.UNIQUE_GEMS = mining_unique_gems
	mining_gameplay.create_map()
	
	
	mining_gameplay.finished_mining.connect(on_finished_mining)
	



func on_finished_mining()->void:
	var gems : Array[MiningGem] = mining_gameplay.find_gems()
	
	GlobalVar.mined_gems.append_array(gems)
	
	GlobalVar.mined_gems_text = "Mined gems: "
	var i : int = 0
	for gem : MiningGem in gems:
		GlobalVar.mined_gems_text += gem.gem_name
		
		if i != gems.size()-1:
			GlobalVar.mined_gems_text += ", "
		else:
			GlobalVar.mined_gems_text += "."
		
		i+=1
		
	GlobalVar.mined_gems.append_array(gems)
	DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, MINING_DIALOGUE_END)
	await DialogueManager.dialogue_ended
	
	queue_free()
	
