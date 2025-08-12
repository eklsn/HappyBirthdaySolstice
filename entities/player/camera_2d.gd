class_name GameCamera
extends Camera2D



func move_to_relative(new_position : Vector2, move_dur : float)->void:
	
	var position_tween : Tween = create_tween()
	
	position_tween.tween_property(self,"position",new_position,move_dur)
	await position_tween.finished
	
	
	
	
