extends Control

@onready var back: Button = $Back

func _ready() -> void:
	back.pressed.connect(_on_back_pressed)
	back.mouse_entered.connect(_on_button_hover)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		AudioManager.play_button_hover_sound()
		_on_back_pressed()
			
func _on_back_pressed() -> void:
	AudioManager.play_button_click_sound()
	GameManager.change_scene("main_menu")
	
func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()
