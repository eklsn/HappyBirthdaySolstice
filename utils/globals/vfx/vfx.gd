extends CanvasLayer

func get_vfx(vfx_path : StringName)->Node:
	
	for child : Node in get_children():
		if ResourceUID.id_to_text(ResourceLoader.get_resource_uid(child.scene_file_path)) == vfx_path:
			
			return child
		
	
	
	
	var vfx : Node = load(vfx_path).instantiate()
	add_child(vfx)
	return vfx
