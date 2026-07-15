## GLOBAL - AudioManager
extends Node

## SFX
const CHICKEN_SFX_UI_BEEPS_ACTIVATE : AudioStreamWAV = preload("uid://smmmbuk7becd")
const CHICKEN_SFX_UI_BEEP_1 : AudioStreamWAV = preload("uid://djix8s06erfaa")
const CHICKEN_SFX_GETTING_HIT_IMPACT : AudioStreamWAV = preload("uid://dtslptl8ip8s1")


## MUSIC
const PROJECT_76_3 : AudioStreamMP3 = preload("uid://be5eusl3scf52") # TODO: Replace with WAV file

@onready var sound_effects_player: AudioStreamPlayer = %SoundEffectsPlayer
@onready var background_music_player: AudioStreamPlayer = %BackgroundMusicPlayer

func _ready() -> void:
	play_background_music()

## Button Hover Sound
func play_button_hover_sound() -> void:
	sound_effects_player.stream = CHICKEN_SFX_UI_BEEP_1
	sound_effects_player.play()

## Button Click Sound
func play_button_click_sound() -> void:
	sound_effects_player.stream = CHICKEN_SFX_UI_BEEPS_ACTIVATE
	sound_effects_player.play()

## Main Menu background music
func play_background_music() -> void:
	background_music_player.stream = PROJECT_76_3
	background_music_player.play()

func play_chicken_hit_sound() -> void:
	sound_effects_player.stream = CHICKEN_SFX_GETTING_HIT_IMPACT
	sound_effects_player.play()
