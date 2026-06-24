extends Node

enum GameState { PLAYING, GAME_OVER }

var state: GameState = GameState.PLAYING

signal Hit


func _ready() -> void:
	Hit.connect(_on_hit)


func _on_hit() -> void:
	state = GameState.GAME_OVER
