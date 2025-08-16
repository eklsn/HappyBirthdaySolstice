class_name CreateMiningMinigameInteraction
extends Interaction

@export var textbox : StringName = "uid://dllel4wxacax2"

@export var mining_setup : MiningSetup

const MINING_GAME : StringName = "uid://dkdy7tab8dwks"



func interact()->void:
	var mining_game : MiningMinigameSetup = load(MINING_GAME).instantiate()
	mining_game.mining_setup = mining_setup
	Vfx.add_child(mining_game)
	
	holder.get_parent().queue_free()
	
	
	
