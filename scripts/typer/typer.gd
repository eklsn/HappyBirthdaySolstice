extends RichTextLabel
class_name Typer

var typing = false
var typespeed
var full_text
var type_index
var curtyper

var pause_chars = {
	"." : 0.4,
	"," : 0.2,
}

var sounds = {
	-1 : "",
	0 : "res://audio/player/snd_badexplosion.wav"
}

func start_typing(type_text : String, typer : int, speed : float = 0.05):
	full_text = type_text
	text = full_text
	typespeed = speed
	curtyper = typer
	type_index = 0
	visible_characters = 0
	typing = true
	type_next()

func type_add(add_text : String, speed : float = -1):
	full_text += add_text
	text = full_text
	if speed > 0:
		typespeed = speed

	if !typing:
		typing = true
		type_next()

func type_next():
	if !typing || type_index >= strip_bbcode(full_text).length():
		typing = false
		return

	type_index += 1
	if curtyper == 0:
		Audio.stop("speak")
	Audio.play("speak",self,load(sounds[curtyper]))
	Audio.volset("speak",0.1)
	visible_characters = type_index

	var next_char = strip_bbcode(full_text)[type_index - 1]
	var pause = typespeed
	if pause_chars.has(next_char):
		pause = pause_chars[next_char]

	var timer = Timer.new()
	timer.wait_time = pause
	timer.one_shot = true
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(type_next)

func skip():
	visible_characters = -1
	typing = false

func strip_bbcode(source: String):
	var regex = RegEx.new()
	regex.compile("\\[.+?\\]")
	return regex.sub(source, "", true)
