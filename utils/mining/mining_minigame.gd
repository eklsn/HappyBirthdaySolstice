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
	
	on_mined()
	
	
	
	if not GlobalVar.plot ==  4.95 || GlobalVar.still_hope_rocks_mined > 5:
		return
	
	GlobalVar.still_hope_rocks_mined+=1
	
	if GlobalVar.still_hope_rocks_mined == 5:
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, load("uid://bdvl3rkeam20e"))
		await DialogueManager.dialogue_ended
		
	
	
	#mining_gameplay.mined.connect(on_mined)





#Solstice: To think that I had to get to the Moon to break free of the expectations that humans forced on me. I'm even having a hard time realizing how much I've been conditioned by them.  
#do wait(1.0)
#Solstice: Just because they have the label of "mother" and "father" on them, they think they can plan the entire life of their children and constrain them into a shape that doesn't belong to them. It's disgusting.  
#do wait(1.0)
#Solstice: "Go study electronic engineering, Solstice, you'll make a lot of money!" Not only did I not make much money in the first place, but now my savings got nuked, too. What a waste of time.  
#do wait(1.0)
#Solstice: They always made everything sound like a suggestion, but it was just their way to order me to do what they wanted. You could see their personalities twist and become unbearable when things didn't go as they wanted.  
#do wait(1.0)
#Solstice: My human parents used me as a toy, and whoever was tasked with overseeing me from heaven just abandoned me, too. Wish they could throw a nuke up there too. They would survive, sadly.  
#do wait(1.0)
#Solstice: I just wanted to make music and enjoy playing with other people like me.  

# When she has everything, one last line of dialogue triggers.  
#do wait(3.0)
#Solstice: I'm gonna turn things around.  
#do wait(5.0)

const HOME_ACTUALLY_FILLER_1 : DialogueResource = preload("uid://ciy80re3jf82n")
const HOME_ACTUALLY_FILLER_2 : DialogueResource = preload("uid://caqlu0mr4ghg3")
const HOME_ACTUALLY_FILLER_3 : DialogueResource = preload("uid://c8343w8j046s4")
const HOME_ACTUALLY_FILLER_4  : DialogueResource= preload("uid://dmqd54v8w8eo6")
const HOME_ACTUALLY_FILLER_5  : DialogueResource= preload("uid://beipt0ya0hnl7")
const HOME_ACTUALLY_FILLER_6  : DialogueResource= preload("uid://dd5l3ksmtcxhi")
const HOME_ACTUALLY_FILLER_FINAL  : DialogueResource= preload("uid://bro006osbydf1")

func on_mined()->void:
	
	if not GlobalVar.plot == 3.2:
		return
	
	if GlobalVar.home_actually_finished:
		return
		
		
	var filers : Array[DialogueResource] = [
		HOME_ACTUALLY_FILLER_1,
		HOME_ACTUALLY_FILLER_2,
		HOME_ACTUALLY_FILLER_3,
		HOME_ACTUALLY_FILLER_4,
		HOME_ACTUALLY_FILLER_5,
		HOME_ACTUALLY_FILLER_6,
		
	]
	
	if GlobalVar.home_actually_filler_counter > 5:
		#GlobalVar.home_actually_finished = true
		#DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX,HOME_ACTUALLY_FILLER_FINAL)
		
		return
	
	
	
	
	
	DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, filers[GlobalVar.home_actually_filler_counter])
	
	
	
	
	
	GlobalVar.home_actually_filler_counter+=1
	
	
	
	







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
		
		
		
	
	if GlobalVar.plot == 3.2 && not GlobalVar.home_actually_finished:
		
		
		if GlobalVar.home_actually_filler_counter > 5:
			GlobalVar.home_actually_finished = true
			DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX,HOME_ACTUALLY_FILLER_FINAL)
			await DialogueManager.dialogue_ended
			mined_enough = true
		else:
			mined_enough = false
		
		
		
	
	
	if mined_enough:
		for gem : MiningGem in GlobalVar.needed_gems:
			GlobalVar.mined_gems.erase(gem)
		
		
		GlobalVar.needed_gems.clear()
		
		
		GlobalVar.gems_mined.emit()
	
	
	
	
	
	
	
	
	minigame_finished.emit()
	queue_free()
	
