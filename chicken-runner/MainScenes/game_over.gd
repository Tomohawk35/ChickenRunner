extends Control

@onready var panel: Panel = $Panel

func _ready() -> void:
	panel.hide()
	GameManager.Hit.connect(_on_game_over)

func _on_game_over() -> void:
	panel.show()
	get_tree().paused = true

func _on_restart_button_down() -> void:
	GameManager.state = GameManager.GameState.PLAYING
	get_tree().paused = false
	get_tree().reload_current_scene()
