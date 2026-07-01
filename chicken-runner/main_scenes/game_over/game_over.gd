extends Control

@onready var panel: PanelContainer = $Panel
@onready var restart: Button = $Panel/VBoxContainer/VBoxContainer/Restart
@onready var backto_menu: Button = $Panel/VBoxContainer/VBoxContainer/BacktoMenu

func _ready() -> void:
	restart.pressed.connect(_on_restart_button_pressed)
	backto_menu.pressed.connect(_on_back_to_menu_pressed)

func _on_game_over() -> void:
	panel.show()
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	GameManager.new_game()

func _on_back_to_menu_pressed() -> void:
	GameManager.change_scene("main_menu")
