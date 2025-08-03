extends Node2D
@export var lerp_position : Vector2
@export var lerp_size : Vector2
var lerpin = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action()

func action():
	self.position = lerp_position
	self.visible = true
	lerpin = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lerpin:
		self.position = lerp(self.position, lerp_position, 0.2)
		$txtbox_bg.size = lerp($txtbox_bg.size, lerp_size, 0.1)
