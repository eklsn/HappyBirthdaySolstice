class_name MiningProgressBar
extends ProgressBar

func _ready() -> void:
	grab_focus()
	

func update_bar(new_value : float)->void:
	value = new_value
