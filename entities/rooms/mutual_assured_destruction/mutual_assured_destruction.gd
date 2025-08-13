extends Room

const MUTUAL_ASSURED_DESTRUCTION :Resource = preload("uid://xbbs7euvm7rw")
const MAIN_TEXTBOX = preload("uid://dllel4wxacax2")

@onready var shito: CharacterBody2D = %Shito
@onready var flash : ColorRect = %new3_flash
@onready var shito_sit_position: Marker2D = $ShitoSitPosition
@onready var dialogue_timer: Timer = $DialogueTimer

const DIALOGUE_FILLER_WAIT_TIME : float = 4.0

var plot : int = 0
var dialogue_counter : int = 6

const PLAYER_FOLLOWING :PackedScene = preload("uid://cjbftteb7m838")

const NEW_BEGGINING_FILLER_1 :Resource = preload("uid://bcd76lon0v2sj")
const NEW_BEGGINING_FILLER_2 :Resource = preload("uid://da1es03l8ci2m")
const NEW_BEGGINING_FILLER_3 :Resource = preload("uid://bx8eb557e4lt5")
const NEW_BEGGINING_FILLER_4 :Resource = preload("uid://qug2udfkfle4")
const NEW_BEGGINING_FILLER_5 :Resource = preload("uid://1mbai0567w21")
const NEW_BEGGINING_FILLER_6 :Resource = preload("uid://b20xxnelyyff4")
const NEW_BEGGINING_FILLER_7 :Resource = preload("uid://cgld5fhhu1dcq")


var fillers : Array[Resource] = [
	
	NEW_BEGGINING_FILLER_1,
NEW_BEGGINING_FILLER_2,
NEW_BEGGINING_FILLER_3,
NEW_BEGGINING_FILLER_4,
NEW_BEGGINING_FILLER_5,
NEW_BEGGINING_FILLER_6,
NEW_BEGGINING_FILLER_7,
	
	
]

const NEW_BEGGINING_2 :Resource = preload("uid://cbwienwo3lkln")
const NEW_BEGGINING_3 :Resource = preload("uid://b22wylte268oi")

func on_enter_room()->void:
	if DialogueManager.dialogue_playing:
		await DialogueManager.dialogue_ended
		
	DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, MUTUAL_ASSURED_DESTRUCTION)
	
	await DialogueManager.dialogue_ended
	var prev_pos : Vector2 = shito.global_position
	shito.queue_free()
	shito = PLAYER_FOLLOWING.instantiate()
	add_child(shito)
	shito.global_position = prev_pos
	
	#dialogue_counter=5
	dialogue_timer.start(DIALOGUE_FILLER_WAIT_TIME)
	
	


func _on_dialogue_timer_timeout() -> void:
	var wait_time : float
	if plot < 1:
		var current_filler : Resource = fillers[dialogue_counter]
		wait_time = DIALOGUE_FILLER_WAIT_TIME
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, current_filler)
	if plot == 1:
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
		plot = 1
		_on_dialogue_timer_timeout()
		return
	dialogue_timer.start(wait_time)
	
