extends Room

#const MUTUAL_ASSURED_DESTRUCTION :Resource = preload("uid://xsjcuqwqpafb")
const MUTUAL_ASSURED_DESTRUCTION :Resource = preload("uid://blrsffblcjybk")
const MAIN_TEXTBOX = preload("uid://dllel4wxacax2")
var current_dialogue : Resource

@onready var shito: CharacterBody2D = %Shito
@onready var flash : ColorRect = %new3_flash
@onready var shito_sit_position: Marker2D = $ShitoSitPosition
@onready var dialogue_timer: Timer = $DialogueTimer

const DIALOGUE_FILLER_WAIT_TIME : float = 4.0

var dialogue_counter : int = 6

const PLAYER_FOLLOWING :PackedScene = preload("uid://cjbftteb7m838")

const NEW_BEGGINING_FILLER_1 :Resource = preload("uid://brej2kkku1c5b")
const NEW_BEGGINING_FILLER_2 :Resource = preload("uid://blrnlm5yo38gu")
const NEW_BEGGINING_FILLER_3 :Resource = preload("uid://defqt88yfk5fo")
const NEW_BEGGINING_FILLER_4 :Resource = preload("uid://duhdxlq1te1h5")
const NEW_BEGGINING_FILLER_5 :Resource = preload("uid://b1bgarxct3m5x")
const NEW_BEGGINING_FILLER_6 :Resource = preload("uid://bbuu0gklcg842")
const NEW_BEGGINING_FILLER_7 :Resource = preload("uid://dh7tio75ofw6r")

const HOME_KINDA_3 : Resource = preload("uid://blrsffblcjybk")

var fillers : Array[Resource] = [
	
	NEW_BEGGINING_FILLER_1,
NEW_BEGGINING_FILLER_2,
NEW_BEGGINING_FILLER_3,
NEW_BEGGINING_FILLER_4,
NEW_BEGGINING_FILLER_5,
NEW_BEGGINING_FILLER_6,
NEW_BEGGINING_FILLER_7,
	
	
]

const NEW_BEGGINING_2 :Resource = preload("uid://p2qpm517xoom")
const NEW_BEGGINING_3 :Resource = preload("uid://cgvemca2np160")

func plotcheck() -> void:
	match(GlobalVar.plot):
		0:
			get_node("Tent").visible = false
			current_dialogue = MUTUAL_ASSURED_DESTRUCTION
		2.2:
			get_node("Tent").visible = true
			get_node("RoomEntranceLocations").enabled = false
			get_node("RoomEntranceLocations/RoomEntrance2").position = Vector2(-386,203)
			GlobalVar.player.position = Vector2(-386,203)
		3.0:
			get_node("Tent").visible = true
			get_node("RoomEntranceLocations").enabled = false
			get_node("RoomEntranceLocations/RoomEntrance2").position = Vector2(-386,203)
			GlobalVar.player.position = Vector2(-386,203)
func on_enter_room()->void:
	plotcheck()
	if DialogueManager.dialogue_playing:
		await DialogueManager.dialogue_ended
	if GlobalVar.plot == 0:
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, current_dialogue)
		await DialogueManager.dialogue_ended
		var prev_pos : Vector2 = shito.global_position
		shito.queue_free()
		shito = PLAYER_FOLLOWING.instantiate()
		add_child(shito)
		shito.global_position = prev_pos
		#dialogue_counter=5
		dialogue_timer.start(DIALOGUE_FILLER_WAIT_TIME)
	if GlobalVar.plot == 2.3:
		current_dialogue = HOME_KINDA_3
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, current_dialogue)
		await DialogueManager.dialogue_ended
	
	


func _on_dialogue_timer_timeout() -> void:
	var wait_time : float
	if GlobalVar.plot < 1:
		var current_filler : Resource = fillers[dialogue_counter]
		wait_time = DIALOGUE_FILLER_WAIT_TIME
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, current_filler)
	if GlobalVar.plot == 1:
		match dialogue_counter:
			0:
				wait_time = 0.0
				DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, NEW_BEGGINING_2)
			1:
				wait_time = 0.0
				DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, NEW_BEGGINING_3)
	
	await DialogueManager.dialogue_ended
	dialogue_counter+=1
	if fillers.size() == dialogue_counter:
		dialogue_counter = 0
		GlobalVar.plot = 1
		_on_dialogue_timer_timeout()
		return
	dialogue_timer.start(wait_time)
	
