extends ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal animation_finished

func fade_in()->void:
	
	animation_player.play("fade_in")
	await animation_player.animation_finished
	animation_finished.emit()

func fade_out()->void:
	
	animation_player.play("fade_out")
	#await animation_player.animation_finished
	await GlobalVar.get_tree().create_timer(0.05,false).timeout
	
	
	#await animation_player.animation_finished
	#animation_finished.emit()
	
	
