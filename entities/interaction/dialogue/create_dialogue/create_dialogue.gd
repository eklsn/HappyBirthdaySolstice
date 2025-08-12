class_name CreateDialogueInteraction
extends Interaction

@export var textbox : StringName = "uid://dllel4wxacax2"

@export var dialogue_resource : DialogueResource

func interact()->void:
	DialogueManager.show_dialogue_balloon_scene(load(textbox), dialogue_resource)
