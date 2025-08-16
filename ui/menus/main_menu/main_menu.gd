class_name MainMenu
extends Control


@onready var item_list: ItemList = $ItemList

func _ready() -> void:
	var ILMENITE_TITANIUM :MiningGem= load("uid://ugi7i0evcrkl")
	var INDIUM :MiningGem= load("uid://bj0tpv7x7bnfv")
	var OSMIUM :MiningGem = load("uid://ce3pk3pdvq61n")
	var PLATINUM :MiningGem = load("uid://burj3k8r83vs8")
	var QUARTZ :MiningGem = load("uid://da5tbxi127k7f")
	var RHODIUM :MiningGem = load("uid://cfrl3ogy8mbqd")
	var RHUTENIUM :MiningGem = load("uid://q3a7408j4bsp")
	
	
	
	
	
	
	var gems : Array[MiningGem] = [ILMENITE_TITANIUM, INDIUM, OSMIUM, PLATINUM, QUARTZ, RHODIUM, RHUTENIUM]
	
	for i in range(gems.size()):
		var gem : MiningGem = gems[i]
		var mined_count : int = GlobalVar.mined_gems.count(gem)
		var needed_count : int = GlobalVar.needed_gems.count(gem)
		var text :String = gem.gem_name + " " + str(mined_count)
		if needed_count > 0:
			text += "/" + str(needed_count)
		
		item_list.set_item_text(i, text)
		
		
	
	
	
	
	
	



#func menu_button_gui_input(event : InputEvent)->void:
	#if event.is_action_pressed("ui_cancel") || event.is_action_pressed("open_menu") || event.is_action_pressed("ui_accept"):
		#queue_free()
		#accept_event()
	



func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("open_menu") || event.is_action_pressed("ui_accept"):
		queue_free()
		accept_event()
	else:
		accept_event()
	
	
