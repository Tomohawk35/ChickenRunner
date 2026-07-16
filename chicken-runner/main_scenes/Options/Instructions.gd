extends PanelContainer

@onready var movement: RichTextLabel = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Movement
@onready var abilities: RichTextLabel = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Abilities
@onready var pause_label: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/pause
@onready var close_button: Button = $Panel/Button

func _ready() -> void:
	_populate()
	close_button.pressed.connect(_on_close_pressed)
	close_button.mouse_entered.connect(AudioManager.play_button_hover_sound)

func _populate() -> void:
	movement.text = "[center][b][color=gold][font_size=24] MOVEMENT CONTROLS[/font_size][/color][/b][/center]\n\nUp\t-\t%s\nLeft\t-\t%s\nDown\t-\t%s\nRight\t-\t%s" % [
		_key_for("up"), _key_for("left"), _key_for("down"), _key_for("right")
	]
	abilities.text = "[center][b][color=gold][font_size=24]Abilities[/font_size][/color][/b][/center]\n\nUse Consumable\t-\t%s\nUse Equipment\t-\t%s\nToggle Equipment\t-\t%s" % [
		_key_for("use_consumable"), _key_for("use_equipment"), _key_for("toggle_equipment")
	]
	pause_label.text = "Pause - %s" % _key_for("escape")

func _key_for(action: String) -> String:
	if not InputMap.has_action(action):
		return "Unassigned"
	for event in InputMap.action_get_events(action):
		if event is InputEventKey:
			if event.physical_keycode != 0:
				return event.as_text_physical_keycode()
			return event.as_text_keycode()
	return "Unassigned"

func open() -> void:
	_populate()
	get_tree().paused = true
	show()

func _on_close_pressed() -> void:
	AudioManager.play_button_click_sound()
	get_tree().paused = false
	hide()
