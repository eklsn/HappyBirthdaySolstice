class_name FollowerNPC2
extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var target_player: Player
var position_history: Array[Vector2] = []
var direction_history: Array[String] = []
var speed_history: Array[float] = []
var last_dir := "down"

# Following parameters
const MAX_HISTORY_SIZE := 10
const HISTORY_STEPS_BACK := 6  # How many steps behind the player to follow
const MIN_DISTANCE_TO_MOVE := 5.0  # Only move if target is this far away

var is_moving := true

func _ready():
	# Find the player in the scene
	target_player = GlobalVar.player
	if not target_player:
		push_error("No player found! Make sure player is in 'player' group")

func _physics_process(_delta: float):
	if not target_player or not is_moving:
		_play_idle_animation()
		return
	
	#queue_redraw()
	_follow_player()
	_update_animation()

func _follow_player():
	var target_pos: Vector2
	var target_speed: float
	
	# If we don't have enough history yet, follow the player directly
	if position_history.size() <= HISTORY_STEPS_BACK:
		target_pos = target_player.global_position
		target_speed = target_player.velocity.length()
		last_dir = target_player.last_dir
	else:
		# Use historical position for delayed following
		target_pos = position_history[HISTORY_STEPS_BACK]
		target_speed = speed_history.get(HISTORY_STEPS_BACK)
		
		# Update direction from history
		if direction_history.size() > HISTORY_STEPS_BACK:
			last_dir = direction_history[HISTORY_STEPS_BACK]
	
	var distance_to_target = global_position.distance_to(target_pos)
	
	# Only move if target is far enough away
	if distance_to_target < MIN_DISTANCE_TO_MOVE:
		velocity = Vector2.ZERO
		return
	
	var direction = (target_pos - global_position).normalized()
	velocity = direction * target_speed
	move_and_slide()

func _update_animation():
	var is_moving_now = velocity.length() > 10.0
	
	var anim_name = "idle_"
	if is_moving_now:
		anim_name = "walk_"
		if target_player.is_running:
			anim_name = "run_"
	
	anim.play(anim_name + last_dir)

func _play_idle_animation():
	anim.play("idle_" + last_dir)

func set_following(follow: bool):
	is_moving = follow

#func _draw():
	## Debug visualization of target position
	#if position_history.size() > HISTORY_STEPS_BACK:
		#var target_pos = position_history[HISTORY_STEPS_BACK] - global_position
		#draw_circle(target_pos, 3, Color.RED)

func _on_position_recording_timeout():
	if target_player.velocity.length() > 0:
		position_history.append(target_player.global_position)
		direction_history.append(target_player.last_dir)
		speed_history.append(target_player.velocity.length())
		
		# Maintain history size limit
		if position_history.size() > MAX_HISTORY_SIZE:
			position_history.pop_front()
			direction_history.pop_front()
			speed_history.pop_front()
