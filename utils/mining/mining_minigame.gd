class_name MiningMinigameSetup
extends Node

const MAIN_TEXTBOX : PackedScene = preload("uid://dllel4wxacax2")
const MINING_DIALOGUE_END : Resource = preload("uid://c4xwdme27roj")

@onready var mining_gameplay: MiningGameplay = $MiningGameplay

@export var mining_setup : MiningSetup

signal minigame_finished

func _ready() -> void:
	var mining_unique_gems : Array[MiningGem] = []
	mining_unique_gems.assign(mining_setup.mining_gems)
	
	var unique_gems : Array[MiningGem] = []
	for gem in mining_unique_gems:
		if gem not in unique_gems:
			
			unique_gems.append(gem)
	
	mining_unique_gems = unique_gems
	
	
	
	mining_gameplay.mining_gems = mining_setup.mining_gems
	mining_gameplay.UNIQUE_GEMS = mining_unique_gems
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
	
	if not DialogueManager.dialogue_playing:
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, MINING_DIALOGUE_END)
		await DialogueManager.dialogue_ended
	
	var ILMENITE_TITANIUM :MiningGem= load("uid://ugi7i0evcrkl")
	var INDIUM :MiningGem= load("uid://bj0tpv7x7bnfv")
	var OSMIUM :MiningGem = load("uid://ce3pk3pdvq61n")
	var PLATINUM :MiningGem = load("uid://burj3k8r83vs8")
	var QUARTZ :MiningGem = load("uid://da5tbxi127k7f")
	var RHODIUM :MiningGem = load("uid://cfrl3ogy8mbqd")
	var RHUTENIUM :MiningGem = load("uid://q3a7408j4bsp")
	
	var all_gems : Array[MiningGem] = [ILMENITE_TITANIUM, INDIUM, OSMIUM, PLATINUM, QUARTZ, RHODIUM, RHUTENIUM]
	
	var mined_enough : bool = true
	
	for gem : MiningGem in all_gems:
		var mined_count : int = GlobalVar.mined_gems.count(gem)
		var needed_count : int = GlobalVar.needed_gems.count(gem)
		
		if mined_count < needed_count:
			mined_enough = false
		
		
	
	
	if GlobalVar.plot == 2.05 && not DialogueManager.dialogue_playing:
		GlobalVar.mined_gems_text = "A chunk came off with some metal streaks in it, maybe it's the yttrium we need."
		GlobalVar.mined_gems.append(ILMENITE_TITANIUM)
		
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, MINING_DIALOGUE_END)
		await DialogueManager.dialogue_ended
		mined_enough = true
		
		
		
	
	
	if mined_enough:
		for gem : MiningGem in GlobalVar.needed_gems:
			GlobalVar.mined_gems.erase(gem)
		
		
		GlobalVar.needed_gems.clear()
		
		
		GlobalVar.gems_mined.emit()
	
	
	
	
	
	
	
	
	minigame_finished.emit()
	queue_free()
	
