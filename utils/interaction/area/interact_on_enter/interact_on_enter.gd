class_name AreaInteractOnEnter
extends AreaInteract




func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		interaction.interact()
		
