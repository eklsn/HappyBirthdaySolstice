extends Control

const INTRO = preload("uid://8bljbfosdksn")

const NO_TEXTBOX_BALLOON = preload("uid://de3j0chg2tig1")
@onready var intro_image: TextureRect = $IntroImage
const INTRO_PANEL_1 = preload("uid://cyi8a0uyckk36")
const INTRO_PANEL_2 = preload("uid://dkmxnkwdehbme")
const INTRO_PANEL_2_5=preload("uid://ctkeabtgb38ec")
const INTRO_PANEL_3 = preload("uid://crd00xixnv1dq")
const INTRO_PANEL_4 = preload("uid://cngcexyittiuo")
const INTRO_PANEL_5 = preload("uid://cwe0aeubxkri0")
const INTRO_PANEL_7 = preload("uid://2ytd7u0gu1sn")

var intro_panels :Array[Texture2D] = [
INTRO_PANEL_1,
INTRO_PANEL_2,
INTRO_PANEL_2_5,
INTRO_PANEL_3,
INTRO_PANEL_4,
INTRO_PANEL_5,
INTRO_PANEL_7
]



func _ready() -> void:
	DialogueManager.show_dialogue_balloon_scene(NO_TEXTBOX_BALLOON, INTRO)
	

func switch_image(image_index : int)->void:
	intro_image.texture = intro_panels[image_index]
	
