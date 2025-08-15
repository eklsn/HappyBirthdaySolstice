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


func plotcheck() -> void:
	pass
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


	
