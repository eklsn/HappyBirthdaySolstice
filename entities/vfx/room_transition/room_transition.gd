extends ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal animation_finished

func fade_in(fade_time : float = 0.4)->void:
	
	var fade_tween : Tween = create_tween()
	fade_tween.tween_property(self, "self_modulate", Color(1.0,1.0,1.0,1.0),fade_time)
	await fade_tween.finished
	
	animation_finished.emit()

func fade_out(fade_time : float = 0.32)->void:
	
	var fade_tween : Tween = create_tween()
	fade_tween.tween_property(self, "self_modulate", Color(1.0,1.0,1.0,0.0),fade_time)
	await fade_tween.finished
	
	#await animation_player.animation_finished
	await GlobalVar.get_tree().create_timer(0.05,false).timeout
	
	queue_free()
	
	#await animation_player.animation_finished
	#animation_finished.emit()
	
	
