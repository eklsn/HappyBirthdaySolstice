extends Node2D

var move_pos : Vector2
var scale_target : Vector2
var move_size : Vector2
var move_type : String
var scale_type : String 
var move_speed : float
var scale_speed : float
var prev_pos : Vector2
var animing : bool = false
var effects : Array
var fadedir : float = -0.005
var forceanim = false
var animargs
var nov_name : String
var prev_order : int
var prev_scale : Vector2
	
	
	# OLD AND UNFINISHED SCRIPT! NEEDS REVISING LATER ON, (but it's functional)
	
	
	
func move(pos : Vector2, type : String, speed : float):
	move_pos = pos
	move_type = type
	move_speed = speed
	effects.append("move")
	
func do_scale(target : Vector2, type : String = "lerp", speed : float = 0.1):
	scale_target = target
	scale_type = type
	scale_speed = speed
	effects.append("scale")
	

func animplay(animation : String, args : Array):
	animargs = args
	callv("anim_"+animation, args)
	
func _physics_process(delta : float) -> void:
		
	if effects.has("zoom"):
		if !effects.has("fade") && !effects.has("scale"):
			effects.erase("zoom")
	if effects.has("jscale"):
		if !effects.has("jump") && !effects.has("scale"):
			effects.erase("jscale")
			
	if effects.has("fade"):
		modulate.a += fadedir
		if fadedir < 0 && modulate.a <= 0:
			effects.erase("fade")
		if fadedir > 0 && modulate.a >= 1:
			effects.erase("fade")
			
	if !effects.is_empty() || forceanim:
		animing = true
		
	if effects.has("scale"):
		if scale_type == "lerp":
			scale = lerp(scale,scale_target,scale_speed)
		if scale_type == "square":
			scale.x = move_toward(scale.x,scale_target.x,scale_speed)
			scale.y = move_toward(scale.y,scale_target.y,scale_speed)
		if scale_type == "none":
			scale = scale_target
			
	if effects.has("move") || effects.has("jump"):
		if move_type == "lerp":
			position = lerp(position,move_pos,move_speed)
		if move_type == "square":
			position.x = move_toward(position.x,move_pos.x,move_speed)
			position.y = move_toward(position.y,move_pos.y,move_speed)
		if move_type == "none":
			position = move_pos
			
		if position == move_pos || round(position) == move_pos:
			if effects.has("move"):
				effects.erase("move")
			if effects.has("jump"):
				move_pos = prev_pos
				move_speed = move_speed/3
				if position == move_pos:
					effects.erase("jump")
	
func anim_fade(fadedirection = -0.005):
	fadedirection = float(fadedirection)
	if fadedirection < 0:
		modulate.a = 1
	if fadedirection > 0:
		modulate.a = 0
	fadedir = fadedirection
	self.visible = true
	effects.append("fade")

func anim_zoom(dir):
	if dir == "in":
		anim_fade(0.05)
		scale = scale/1.25
		do_scale(scale*1.25)
	if dir == "out":
		anim_fade(-0.05)
		do_scale(scale/1.25)
