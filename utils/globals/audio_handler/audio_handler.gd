extends Node

@onready var mine: AudioStreamPlayer = $MiningSound

@onready var moonhouse: AudioStreamPlayerLinearVolume = $Moonhouse
@onready var moon_amb: AudioStreamPlayerLinearVolume = $MoonAmb
@onready var opening_amb: AudioStreamPlayerLinearVolume = $OpeningAmb



const VERY_SHORT_LERP_TIME := 1.0




func _ready() -> void:
	
	AudioHandler.lerp_to_none(AudioHandler.opening_amb)
	
	AudioHandler.lerp_from_none_to_max(AudioHandler.opening_amb)
	
	









# methods

# slowly transitions the specified sound to the specified volume, the volume must be linear
func lerp_to_specific_volume(sound: AudioStreamPlayerLinearVolume, specific_volume_level: float, lerp_time: float = VERY_SHORT_LERP_TIME) ->void:
	sound.hidden = false
	if !sound.playing:
		sound.play()
	var tween = get_tree().create_tween()
	tween.tween_property(sound, "volume_level",specific_volume_level,lerp_time)

func lerp_to_specific_volume_mult(sound: AudioStreamPlayerLinearVolume, specific_volume_mult: float, lerp_time: float = VERY_SHORT_LERP_TIME) ->void:
	var tween = get_tree().create_tween()
	tween.tween_property(sound, "volume_mult",specific_volume_mult,lerp_time)




# 
func lerp_to_none(sound: AudioStreamPlayerLinearVolume) ->void:
	sound.hidden = true
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(sound, "volume_level",0.001,VERY_SHORT_LERP_TIME)
	await tween.finished
	sound.stop()

func lerp_from_none_to_max(sound : AudioStreamPlayerLinearVolume, lerp_time: float = VERY_SHORT_LERP_TIME) ->void: # sets the sounds volume db from 0 to 1
	sound.hidden = false
	sound.volume_level = 0.001
	
	
	if !sound.playing:
		sound.play()
	lerp_to_specific_volume(sound, 1, lerp_time)
	
	
