extends Room

const MUTUAL_ASSURED_DESTRUCTION :Resource = preload("uid://xbbs7euvm7rw")
const MAIN_TEXTBOX = preload("uid://dllel4wxacax2")

@onready var shito: CharacterBody2D = %Shito
@onready var shito_sit_position: Marker2D = $ShitoSitPosition
@onready var dialogue_timer: Timer = $DialogueTimer

const DIALOGUE_FILLER_WAIT_TIME : float = 4.0

var dialogue_counter : int = 0

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

func on_enter_room()->void:
	if DialogueManager.dialogue_playing:
		await DialogueManager.dialogue_ended
		
	#DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, MUTUAL_ASSURED_DESTRUCTION)
	
	#await DialogueManager.dialogue_ended
	var prev_pos : Vector2 = shito.global_position
	shito.queue_free()
	shito = PLAYER_FOLLOWING.instantiate()
	add_child(shito)
	shito.global_position = prev_pos
	
	dialogue_counter=5
	dialogue_timer.start(DIALOGUE_FILLER_WAIT_TIME)
	
	


func _on_dialogue_timer_timeout() -> void:
	var current_filler : Resource = fillers[dialogue_counter]
	
	DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, current_filler)
	
	
	await DialogueManager.dialogue_ended
	dialogue_counter+=1
	if fillers.size() == dialogue_counter:
		DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, NEW_BEGGINING_2)
		
		return
	dialogue_timer.start(DIALOGUE_FILLER_WAIT_TIME)
	
