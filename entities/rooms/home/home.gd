extends Room

const HOME_KINDA_1 :Resource = preload("uid://bfo1lg4o68pfv")
const HOME_KINDA_2 :Resource = preload("uid://bjjtp5rbo3nwk")
const MAIN_TEXTBOX = preload("uid://dllel4wxacax2")
var current_dialogue : Resource
@onready var shito: CharacterBody2D = %Shito
@onready var dialogue_timer: Timer = $DialogueTimer

const DIALOGUE_FILLER_WAIT_TIME : float = 4.0
var dialogue_counter : int = 6

const PLAYER_FOLLOWING :PackedScene = preload("uid://cjbftteb7m838")

func plotcheck() -> void:
	match GlobalVar.plot:
		2:
			current_dialogue = HOME_KINDA_1
			get_node("TentDark/BedDark").visible = false
			get_node("TentDark/lantern").visible = false
		2.1:
			get_node("TentDark/BedDark").visible = true
			get_node("TentDark/lantern").visible = true
		2.2:
			get_node("Player").position = Vector2(126,215)
			shito.visible = false
			current_dialogue = HOME_KINDA_2
			get_node("TentDark").visible = false
			DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, current_dialogue)
			

func on_enter_room()->void:
	plotcheck()
	if DialogueManager.dialogue_playing:
		await DialogueManager.dialogue_ended
	DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, HOME_KINDA_1)
	
	await DialogueManager.dialogue_ended
	var prev_pos : Vector2 = shito.global_position
	shito.queue_free()
	shito = PLAYER_FOLLOWING.instantiate()
	add_child(shito)
	shito.global_position = prev_pos
	if GlobalVar.plot == 2.2:
		shito.visible = false
	#dialogue_counter=5
	#dialogue_timer.start(DIALOGUE_FILLER_WAIT_TIME)
	
	


#func _on_dialogue_timer_timeout() -> void:
	#var wait_time : float
	#if plot < 1:
	#	var current_filler : Resource = fillers[dialogue_counter]
	#	wait_time = DIALOGUE_FILLER_WAIT_TIME
	#	DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, current_filler)
	#if plot == 1:
	#	match dialogue_counter:
	#		0:
	#			wait_time = 0.0
	#			DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, NEW_BEGGINING_2)
	#		1:
	#			wait_time = 0.0
	#			DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, NEW_BEGGINING_3)
	
	#await DialogueManager.dialogue_ended
	#dialogue_counter+=1
	#if fillers.size() == dialogue_counter:
	#	dialogue_counter = 0
	#	plot = 1
	#	_on_dialogue_timer_timeout()
	#	return
	#dialogue_timer.start(wait_time)
	
