extends Control
class_name MainMenu

const CHICKEN_SFX_UI_BEEPS_ACTIVATE : AudioStreamWAV = preload("uid://smmmbuk7becd")
const CHICKEN_SFX_UI_BEEPS : AudioStreamWAV = preload("uid://mb6elb3vlre7")
const CHICKEN_SFX_UI_BEEP_1 = preload("uid://djix8s06erfaa")

@onready var start_game_button: Button = %StartGameButton
@onready var options_button: Button = %OptionsButton
@onready var exit_button: Button = %ExitButton
@onready var credits_button: Button = %CreditsButton

@onready var credits_panel: PanelContainer = %CreditsPanel
@onready var close_button: Button = %CloseButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	start_game_button.pressed.connect(_on_start_game_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	close_button.pressed.connect(_on_close_button_pressed)
	
	start_game_button.mouse_entered.connect(_on_button_hover)
	options_button.mouse_entered.connect(_on_button_hover)
	credits_button.mouse_entered.connect(_on_button_hover)
	exit_button.mouse_entered.connect(_on_button_hover)
	close_button.mouse_entered.connect(_on_button_hover)
	
	credits_panel.hide()

func _on_start_game_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	GameManager.new_game()

func _on_options_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	pass

func _on_credits_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	credits_panel.show()

func _on_exit_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	get_tree().quit()

func _on_close_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	credits_panel.hide()

func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()
