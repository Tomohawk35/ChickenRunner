## GLOBAL - AudioManager
extends Node

## SFX
const CHICKEN_SFX_UI_BEEPS_ACTIVATE : AudioStreamWAV = preload("uid://smmmbuk7becd")
const CHICKEN_SFX_UI_BEEP_1 : AudioStreamWAV = preload("uid://djix8s06erfaa")
const CHICKEN_SFX_GETTING_HIT_IMPACT : AudioStreamWAV = preload("uid://dtslptl8ip8s1")
const CHICKEN_SFX_1_COCKLEDOODLEDOO : AudioStreamMP3 = preload("res://assets/sfx/CHICKEN SFX 1 COCKLEDOODLEDOO.mp3")
const CAR_DRIVING_BY_WITH_HONK : AudioStreamMP3 = preload("res://assets/sfx/CAR DRIVING BY WITH HONK.mp3")
const CHICKEN_EGG_SHOOT : AudioStreamMP3 = preload("res://assets/sfx/CHICKEN EGG SHOOT.mp3")
const CHICKEN_GOLD_FEATHER : AudioStreamMP3 = preload("res://assets/sfx/CHICKEN GOLD FEATHER.mp3")
const CHICKEN_SFX_BA_CAW___COPY : AudioStreamMP3 = preload("res://assets/sfx/CHICKEN SFX BA CAW - Copy.mp3")
const CHICKEN_SFX_POWER_UP : AudioStreamMP3 = preload("res://assets/sfx/CHICKEN SFX POWER UP.mp3")
const CHICKEN_STEP_FORWARD_MIXED_SINGLE : AudioStreamMP3 = preload("res://assets/sfx/CHICKEN Step Forward MIXED SINGLE.mp3")
const CHICKEN_WALKING_ON_PUDDLE : AudioStreamMP3 = preload("res://assets/sfx/CHICKEN Walking on Puddle.mp3")
const DIE_OF_HEAT : AudioStreamMP3 = preload("res://assets/sfx/DIE OF HEAT.mp3")
const HOT_SIZZLING___SOUND_EFFECT : AudioStreamMP3 = preload("res://assets/sfx/Hot Sizzling - Sound Effect.mp3")
const SNAKE_HISSING : AudioStreamMP3 = preload("res://assets/sfx/SNAKE HISSING.mp3")
const WATER_COOL_OFF : AudioStreamMP3 = preload("res://assets/sfx/WATER COOL OFF.mp3")


## MUSIC
const PROJECT_76_3 : AudioStreamMP3 = preload("uid://be5eusl3scf52") # TODO: Replace with WAV file

@onready var sound_effects_player: AudioStreamPlayer = %SoundEffectsPlayer
@onready var background_music_player: AudioStreamPlayer = %BackgroundMusicPlayer
@onready var sizzle_effect_player: AudioStreamPlayer = %SizzleEffectPlayer

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

func play_chicken_cockledoodledoo_victory_sound() -> void:
	sound_effects_player.stream = CHICKEN_SFX_1_COCKLEDOODLEDOO
	sound_effects_player.play()

func play_sizzle_effect() -> void:
	if sizzle_effect_player.playing:
		return
	sizzle_effect_player.play()

func stop_sizzle_effect() -> void:
	sizzle_effect_player.stop()

func play_heat_death_sfx() -> void:
	sound_effects_player.stream = DIE_OF_HEAT
	sound_effects_player.play()
