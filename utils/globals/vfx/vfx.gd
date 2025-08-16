extends CanvasLayer

@onready var black_screen: ColorRect = $BlackScreen

func fade_in(fade_time : float = 0.4)->void:
	
	var fade_tween : Tween = Vfx.create_tween()
	fade_tween.tween_property(black_screen, "modulate", Color(1.0,1.0,1.0,1.0),fade_time)
	await fade_tween.finished
	

func fade_out(fade_time : float = 0.32)->void:
	
	var fade_tween : Tween = Vfx.create_tween()
	fade_tween.tween_property(black_screen, "modulate", Color(1.0,1.0,1.0,0.0),fade_time)
	await fade_tween.finished
	
	
	




func get_vfx(vfx_path : StringName)->Node:
	
	for child : Node in get_children():
		if ResourceUID.id_to_text(ResourceLoader.get_resource_uid(child.scene_file_path)) == vfx_path:
			
			return child
		
	
	
	
	var vfx : Node = load(vfx_path).instantiate()
	add_child(vfx)
	return vfx
