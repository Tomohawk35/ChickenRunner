extends Control
class_name MainMenu

@onready var start_game_button: Button = %StartGameButton
@onready var options_button: Button = %OptionsButton
@onready var exit_button: Button = %ExitButton

func _ready() -> void:
	start_game_button.pressed.connect(_on_start_game_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _on_start_game_button_pressed() -> void:
	GameManager.new_game()

func _on_options_button_pressed() -> void:
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()
