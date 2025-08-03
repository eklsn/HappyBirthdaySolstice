extends Node

# GameWindow script by EKLSN.

var mode: String = "scale"
var scale
var manual_size: Vector2 = Vector2(640,480)

var current_size : Vector2
var target_size : Vector2

func _ready():
	current_size = get_window().size
	match mode:
		"scale":
			scale = floor(min((DisplayServer.screen_get_size().x-1)/320, (DisplayServer.screen_get_size().y-1)/240))
			Global.dprint(self,"User's screen resolution (with discarded hiDPI) is "+str(DisplayServer.screen_get_size()))
			Global.dprint(self,"Multiplying base resolution by "+str(scale))
			target_size = current_size*scale
		"manual_size": target_size = manual_size
	change_size(target_size)

func change_size(size):
	get_window().size = size
	Global.dprint(self, "Tried to set the window size to "+str(size))
	var screen_size : Vector2i = DisplayServer.screen_get_size()
	var centered = Vector2(screen_size.x / 2 - get_window().size.x / 2, screen_size.y / 2 - get_window().size.y / 2)
	get_window().position = centered
	Global.dprint(self, "Tried to center the window by moving it to "+str(centered))

func _process(delta: float) -> void:
	current_size = get_window().size
