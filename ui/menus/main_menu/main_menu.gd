class_name MainMenu
extends Control

const ILMENITE_TITANIUM :MiningGem= preload("uid://ugi7i0evcrkl")
const INDIUM :MiningGem= preload("uid://bj0tpv7x7bnfv")
const OSMIUM :MiningGem = preload("uid://ce3pk3pdvq61n")
const PLATINUM :MiningGem = preload("uid://burj3k8r83vs8")
const QUARTZ :MiningGem = preload("uid://da5tbxi127k7f")
const RHODIUM :MiningGem = preload("uid://cfrl3ogy8mbqd")
const RHUTENIUM :MiningGem = preload("uid://q3a7408j4bsp")
@onready var item_list: ItemList = $ItemList

func _ready() -> void:
	var gems = [ILMENITE_TITANIUM, INDIUM, OSMIUM, PLATINUM, QUARTZ, RHODIUM, RHUTENIUM]
	
	for i in range(gems.size()):
		var gem = gems[i]
		var mined_count = GlobalVar.mined_gems.count(gem)
		var needed_count = GlobalVar.needed_gems.count(gem)
		var text = gem.gem_name + " " + str(mined_count)
		if needed_count > 0:
			text += "/" + str(needed_count)
		
		item_list.set_item_text(i, text)
		
		
		


func menu_button_gui_input(event : InputEvent)->void:
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("open_menu") || event.is_action_pressed("ui_accept"):
		queue_free()
		accept_event()
	



func _unhandled_key_input(_event: InputEvent) -> void:
	accept_event()
