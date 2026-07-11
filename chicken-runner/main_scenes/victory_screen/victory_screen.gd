extends Control
class_name VictoryScreen

@onready var menu_button: Button = %MenuButton
@onready var exit_button: Button = %ExitButton

func _ready() -> void:
	menu_button.pressed.connect(_on_menu_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	menu_button.mouse_entered.connect(_on_button_hover)
	exit_button.mouse_entered.connect(_on_button_hover)
	
func _on_menu_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	GameManager.change_scene("main_menu")

func _on_exit_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	get_tree().quit()

func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()
