extends Control

@onready var panel: PanelContainer = $Panel
@onready var resume: Button = $Panel/VBoxContainer/Resume
@onready var backto_menu: Button = $Panel/VBoxContainer/BacktoMenu

func _ready() -> void:
	resume.pressed.connect(_on_resume_button_pressed)
	backto_menu.pressed.connect(_on_back_to_menu_pressed)
	resume.mouse_entered.connect(_on_button_hover)
	backto_menu.mouse_entered.connect(_on_button_hover)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if !visible:
			AudioManager.play_button_hover_sound()
			open()
		else:
			AudioManager.play_button_click_sound()
			close()

func _on_resume_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	close()

func _on_back_to_menu_pressed() -> void:
	AudioManager.play_button_click_sound()
	GameManager.change_scene("main_menu")

func open() -> void:
	get_tree().paused = true
	show()

func close() -> void:
	get_tree().paused = false
	hide()
	
func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()
