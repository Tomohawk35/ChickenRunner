extends Control

@onready var panel: PanelContainer = $Panel
@onready var restart: Button = $Panel/VBoxContainer/VBoxContainer/Restart
@onready var backto_menu: Button = $Panel/VBoxContainer/VBoxContainer/BacktoMenu

func _ready() -> void:
	restart.pressed.connect(_on_restart_button_pressed)
	backto_menu.pressed.connect(_on_back_to_menu_pressed)
	restart.mouse_entered.connect(_on_button_hover)
	backto_menu.mouse_entered.connect(_on_button_hover)

func _on_game_over() -> void:
	panel.show()
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	GameManager.new_game()

func _on_back_to_menu_pressed() -> void:
	AudioManager.play_button_click_sound()
	GameManager.change_scene("main_menu")

func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()
