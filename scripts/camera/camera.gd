extends Camera2D
class_name Camera

@export var follow : Node

func _ready() -> void:
	if follow:
		reparent.call_deferred(follow)
		position = follow.global_position
		Global.dprint(self, "Reparanted to follow \""+str(follow.name)+"\" node")
	else:
		Global.dprint(self, "WARNING! Camera node is on scene but not pinned to anything?")
	
