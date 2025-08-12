class_name MainMenu
extends Control




func menu_button_gui_input(event : InputEvent)->void:
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("open_menu"):
		queue_free()
		accept_event()
	



func _unhandled_key_input(_event: InputEvent) -> void:
	accept_event()
