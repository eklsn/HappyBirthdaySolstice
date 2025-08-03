extends Node
var muspath = "res://audio/mus/"
var sndpath = "res://audio/snd/"
var rmpath = "res://rooms/"
var fntpath = "res://fonts/"
var handle_reason = "0"
var overworld = false
var party : Array = []
var delta : float
var curscene
# Called when the node enters the scene tree for the first time.
func _ready():
	# The core of this game is written by EKLSN, and can be used in his future projects.
	print("buble")
	dprint(self, "STARFALL: Demo is alive n kicking!")
func goto(room):
	var prevscene=get_tree().current_scene.scene_file_path
	curscene = load("res://rooms/"+room+".tscn").instantiate().get_name()
	get_tree().change_scene_to_file("res://rooms/"+room+".tscn")
	await get_tree().create_timer(0.1).timeout
	if prevscene==get_tree().current_scene.scene_file_path:
		ERROR("ROOM_NOT_FOUND:\n\""+room+"\"")
	
func dprint(node, text):
	print("["+Time.get_time_string_from_system()+"] ["+node.get_script().get_path()+"("+node.get_name()+")]: "+text)

func wait(time):
	
	await get_tree().create_timer(time).timeout
	
func ERROR(reason):
	handle_reason=reason
	get_tree().change_scene_to_file("res://rooms/room_error.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	delta = _delta
	pass
