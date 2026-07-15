extends Control

@onready var back: Button = $Back
@onready var tab_bar: TabBar = $Options/Panel/MarginContainer/VBoxContainer/TabBar
@onready var sound: Control = $Options/Panel/MarginContainer/VBoxContainer/TabBar/Sound
@onready var controls: Control = $Options/Panel/MarginContainer/VBoxContainer/TabBar/Controls

func _ready() -> void:
	back.pressed.connect(_on_back_pressed)
	back.mouse_entered.connect(_on_button_hover)
	tab_bar.tab_changed.connect(_on_tab_changed)
	_on_tab_changed(tab_bar.current_tab)

func _on_tab_changed(tab: int) -> void:
	AudioManager.play_button_hover_sound()
	sound.visible = tab == 0
	controls.visible = tab == 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		AudioManager.play_button_hover_sound()
		_on_back_pressed()
			
func _on_back_pressed() -> void:
	AudioManager.play_button_click_sound()
	GameManager.change_scene("main_menu")
	
func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()
