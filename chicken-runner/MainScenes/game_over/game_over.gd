extends Control

@onready var panel: Panel = $Panel
@onready var restart: Button = $Panel/VBoxContainer/Restart

func _ready() -> void:
	#panel.hide()
	#GameManager.Hit.connect(_on_game_over)
	restart.pressed.connect(_on_restart_button_pressed)

func _on_game_over() -> void:
	panel.show()
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	#GameManager._current_state = GameManager.GameState.PLAYING
	#get_tree().paused = false
	#get_tree().reload_current_scene()
	GameManager.new_game()
