class_name InteractionPrintMessageInteraction
extends Interaction

@export_multiline var message: String

func interact()->void:
	print(message)
