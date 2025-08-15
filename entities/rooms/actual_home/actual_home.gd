extends Room

const MAIN_TEXTBOX = preload("uid://dllel4wxacax2")
var current_dialogue : Resource
@onready var shito: CharacterBody2D = %Shito
@onready var dialogue_timer: Timer = $DialogueTimer

const PLAYER_FOLLOWING :PackedScene = preload("uid://cjbftteb7m838")

const HOME_ACTUALLY_2 : Resource = preload("uid://dg5ego65iqh2")

func plotcheck() -> void:
	pass
			

func on_enter_room()->void:
	if DialogueManager.dialogue_playing:
		await DialogueManager.dialogue_ended
	if GlobalVar.plot == 3.2:
		shito.visible = true
		GlobalVar.player.get_node("AnimatedSprite2D").sprite_frames = preload("uid://du46w21f7iwoh")
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, HOME_ACTUALLY_2)
	plotcheck()
	await DialogueManager.dialogue_ended
	var prev_pos : Vector2 = shito.global_position
	shito.queue_free()
	shito = PLAYER_FOLLOWING.instantiate()
	add_child(shito)
	shito.global_position = prev_pos
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
	
