extends Control

@onready var panel: PanelContainer = $Panel
@onready var resume: Button = $Panel/VBoxContainer/Resume
@onready var backto_menu: Button = $Panel/VBoxContainer/BacktoMenu

func _ready() -> void:
	resume.pressed.connect(_on_resume_button_pressed)
	backto_menu.pressed.connect(_on_back_to_menu_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if !visible:
			open()
		else:
			close()

func _on_resume_button_pressed() -> void:
	close()

func _on_back_to_menu_pressed() -> void:
	GameManager.change_scene("main_menu")

func open() -> void:
	get_tree().paused = true
	show()

func close() -> void:
	get_tree().paused = false
	hide()
