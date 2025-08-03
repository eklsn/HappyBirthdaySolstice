extends Node

# Script for creating reference txtboxes, needed for pulling out txtbox pos+size+lerp mostly.

func _ready() -> void:
	test()
	
func test():
	# txtbox no pic
	var fulltxtbox = load("res://resources/prefabs/txtbox.tscn").instantiate()
	fulltxtbox.lerp_position = Vector2(10,251)
	fulltxtbox.lerp_size = Vector2(299,80)
	fulltxtbox.find_child("txtbox_bg").size = Vector2(298,80)
	add_child(fulltxtbox)
	fulltxtbox.lerp_position = Vector2(10,150)
	# txtbox pic frame
	var picbox = load("res://resources/prefabs/txtbox.tscn").instantiate()
	picbox.lerp_size = Vector2(80,80)
	picbox.lerp_position = Vector2(-100,150)
	picbox.find_child("txtbox_bg").size = Vector2(80,80)
	add_child(picbox)
	picbox.lerp_position = Vector2(10,150)
	# txtbox name frame
	var namebox = load("res://resources/prefabs/txtbox.tscn").instantiate()
	namebox.lerp_size = Vector2(56,30)
	namebox.lerp_position = Vector2(-300,115)
	namebox.find_child("txtbox_bg").size = Vector2(56,30)
	add_child(namebox)
	namebox.lerp_position = Vector2(10,113)
	# txtbox w pic
	var wpictxtbox = load("res://resources/prefabs/txtbox.tscn").instantiate()
	wpictxtbox.lerp_size = Vector2(213,80)
	wpictxtbox.lerp_position = Vector2(98,250)
	wpictxtbox.find_child("txtbox_bg").size = Vector2(211,80)
	add_child(wpictxtbox)
	wpictxtbox.lerp_position = Vector2(97,150)
