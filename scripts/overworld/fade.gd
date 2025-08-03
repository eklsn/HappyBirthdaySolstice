extends ColorRect

func fade(mode, duration):
	print("e")
	match mode:
		"in":
			self.modulate.a = 1
			create_tween().tween_property(self, "modulate", Color(0,0,0,0), duration)
		"out":
			self.modulate.a = 0
			create_tween().tween_property(self, "modulate", Color(0,0,0,1), duration)
	
