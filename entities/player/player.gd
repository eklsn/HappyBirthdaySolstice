class_name Player
extends CharacterBody2D

@export var main_menu_scene: PackedScene
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interaction_area: Area2D = $InteractionArea
@onready var menu_layer: CanvasLayer = $MenuLayer

@onready var camera_2d: GameCamera = $Camera2D

var run_counter := 0.0
var last_dir := "down"
const SPEED := 130.0
const RUN_SUM := 50.0
var movement_stopped := false
var menu : MainMenu

# Input handling
var input_direction := Vector2.ZERO
var is_running := false

var can_interact : bool = true

func _ready() -> void:
	GlobalVar.player = self
	DialogueManager.dialogue_started.connect(func(_resource: DialogueResource): set_idle(true))
	DialogueManager.dialogue_ended.connect(func(_resource: DialogueResource): set_idle(false))
	

func _unhandled_input(event: InputEvent) -> void:
	# Menu handling
	if event.is_action_pressed("open_menu"):
		menu = main_menu_scene.instantiate()
		menu_layer.add_child(menu)
		
	
	elif event.is_action_pressed("ui_accept"):
		interact()
	
	if movement_stopped:
		return
	
	# Movement input
	input_direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	is_running = Input.is_action_pressed("run")
	


func interact()->void:
	if not can_interact:
		return
	var interactables : Array[Area2D] = interaction_area.get_overlapping_areas()
	interactables = interactables.filter(func(area : Area2D)->bool: return area is AreaInteractOnPress)
	
	if interactables.size() == 0:
		return
	
	var interacting : AreaInteractOnPress = interactables.get(0) as AreaInteractOnPress
	interacting.on_interact()
	
	set_idle(true)
	await get_tree().process_frame
	set_idle(false)
	




func _physics_process(delta: float) -> void:
	# Update animation
	
	if movement_stopped || menu || DialogueManager.dialogue_playing:
		return
	
	
	run_counter = min(run_counter + delta if is_running else 0.0, 2.0)
	
	
	var speed_multiplier = 1.0 + (RUN_SUM / SPEED) * (1.0 + int(run_counter)) if run_counter > 0.0 else 1.0
	velocity = input_direction * SPEED * speed_multiplier
	
	_update_animation()
		
	move_and_slide()
	
	

func _update_animation() -> void:
	
	var is_moving = input_direction != Vector2.ZERO
	
	var anim_name = "idle_"
	if is_moving:
		anim_name = "walk_"
	
	# Determine direction
	var anim_dir = last_dir
	if is_moving:
		if input_direction.y < 0: anim_dir = "up"
		elif input_direction.y > 0: anim_dir = "down"
		elif input_direction.x < 0: anim_dir = "left"
		elif input_direction.x > 0: anim_dir = "right"
		last_dir = anim_dir
	
	# Update interaction area rotation based on direction
	match anim_dir:
		"down": interaction_area.rotation_degrees = 0
		"right": interaction_area.rotation_degrees = -90
		"up": interaction_area.rotation_degrees = 180
		"left": interaction_area.rotation_degrees = 90
	
	
	anim.play(anim_name + anim_dir)

func set_idle(idle: bool) -> void:
	input_direction = Vector2.ZERO
	velocity = Vector2.ZERO
	movement_stopped = idle
	collision_shape_2d.set_deferred("disabled", idle)
	
	if anim.animation.begins_with("walk_"):
		_update_animation()

func teleport(loc: Vector2) -> void:
	global_position = loc



func set_sprite(sprite_name : StringName)->void:
	anim.play(sprite_name)
	
	


func walk_to(new_position: Vector2) -> void:
	
	var start_pos = global_position
	var distance = start_pos.distance_to(new_position)
	var duration = distance / SPEED
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	
	tween.tween_method(_walk_to_update, start_pos, new_position, duration)
	
	await tween.finished
	if anim.animation.begins_with("walk_"):
		var anim_dir : StringName = anim.animation.trim_prefix("walk_")
		
		anim.play("idle_" + anim_dir)


func _walk_to_update(pos: Vector2) -> void:
	var direction = (pos - global_position).normalized()
	
	global_position = pos
	
	var anim_dir = last_dir
	if direction.length() > 0.1:  # Only update if there's significant movement
		if abs(direction.y) > abs(direction.x):
			anim_dir = "down" if direction.y > 0 else "up"
		else:
			anim_dir = "right" if direction.x > 0 else "left"
		last_dir = anim_dir
	
	
	
	anim.play("walk_" + anim_dir)
