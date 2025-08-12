extends Room

const INTRO_SEQUENCE :Resource = preload("uid://8bljbfosdksn")
const MAIN_TEXTBOX = preload("uid://dllel4wxacax2")


func on_enter_room()->void:
	
	print("starting intro")
	DialogueManager.show_dialogue_balloon_scene(MAIN_TEXTBOX, INTRO_SEQUENCE)
	
	
