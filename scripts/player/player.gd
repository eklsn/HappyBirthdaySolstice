#====================================================================================
# Purpose: Control the player, Animating the player, and handle all interaction logic 
# Authors: EKLSN, WillowD
#====================================================================================
extends CharacterBody2D
class_name Player

@export var walk_speed : float = 50 # Walking speed.
@export var running_speed : float = 120 # Running speed.
var speed = walk_speed # Moving speed.
@export var is_disabled : bool = false # Is character frozen (Does moving script perform.)
var anim : String = "down" # Animation playing.
var running : int = 0 # A variable defining is palyer running.
var continue_frame = 1
var input_vector = Vector2.ZERO
var last_vector = Vector2.ZERO
# Input handling and movement
func _ready() -> void:
	Global.dprint(self, "Player's on the scene")
	pass
func _process(delta): # Moving and animation script (MZDEV, with the help of WillowD.)
	if !is_disabled: # If not frozen
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		input_vector = round(input_vector.normalized())
		if input_vector != Vector2.ZERO:
			last_vector = input_vector
		
		#position=round(position)
		if Input.is_action_pressed("cancel"):
			running = 1
			$sprite.speed_scale=1.5
			speed=lerp(speed,running_speed,0.25)
		if !Input.is_action_pressed("cancel"):
			running = 0
			$sprite.speed_scale=1
			speed=lerp(speed,walk_speed,0.25)
		velocity = input_vector * speed	 # Setting velocity.
		move_and_slide() # Move.
		if input_vector != Vector2(0,0): # If player is moving.
			if $sprite.is_playing(): # Is animation playing
				if round(input_vector.y) != -1 && anim=="up":animcheck(input_vector) # Not allowing player to do moonwalk.
				if round(input_vector.y) != 1 && anim=="down":animcheck(input_vector) # Not allowing player to do moonwalk.
				if round(input_vector.x) == -1 && anim=="right":animcheck(input_vector) # Not allowing player to do moonwalk.
				if round(input_vector.x) == 1 && anim=="left":animcheck(input_vector) # Not allowing player to do moonwalk.
				animcheck(input_vector) # Checking which animation to play.
				$sprite.animation=anim # Setting animation.
				continue_frame=$sprite.frame
			if !$sprite.is_playing(): # If animation is not playing, but player moves.
				$sprite.animation=anim # Setting animation.
				$sprite.frame=continue_frame
				$sprite.play() # Playing animation.
		else:	
			$sprite.frame = 0
			$sprite.stop()

func animcheck(input_vector : Vector2): # Function that defines which animation should play
	match input_vector: # Checking the base directions, defining the animation.
		Vector2(0,1):anim = "down" # Checking down direction.
		Vector2(0,-1):anim = "up" # Checking up direction.
		Vector2(1,0):anim = "right" # Checking right direction.
		Vector2(-1,0):anim = "left" # Checking left direction.
	if round(input_vector) == Vector2(-1,1) && anim != "left" && anim != "down": anim = "down" # Checking if the player is walking by diagonal, but playing wrong animation. (down-left)
	if round(input_vector) == Vector2(1,1) && anim != "right" && anim != "down": anim = "down" # (down-right)
	if round(input_vector) == Vector2(-1,-1) && anim != "left" && anim != "up": anim = "up" # (up-left)
	if round(input_vector) == Vector2(1,-1) && anim != "right" && anim != "up": anim = "up" # (up-right)
	# I understand that this code is kinda shitty, it checks all the possibilities of directions. Please tell me how to fix it if you have idea how.

func _on_sprite_frame_changed():
	if input_vector == Vector2(0,0):
		$sprite.stop()
		$sprite.frame=0
