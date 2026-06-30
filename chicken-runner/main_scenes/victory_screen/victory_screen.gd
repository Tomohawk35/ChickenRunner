extends Control
class_name VictoryScreen

@onready var menu_button: Button = %MenuButton
@onready var exit_button: Button = %ExitButton

func _ready() -> void:
	menu_button.pressed.connect(_on_menu_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _on_menu_button_pressed() -> void:
	GameManager.change_scene("main_menu")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
