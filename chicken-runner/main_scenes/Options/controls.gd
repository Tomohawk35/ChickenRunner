extends PanelContainer

@onready var _buttons := {
	"up": %UpButton,
	"left": %LeftButton,
	"down": %DownButton,
	"right": %RightButton,
	"use_consumable": %ConsumableButton,
	"use_power_up": %PowerUpButton,
	"toggle_power_up": %TogglePowerUpButton,
	"use_equipment": %EquipmentButton,
}

var _remap_action: String = ""
var _remap_button: Button = null

func _ready() -> void:
	print("[DIAG] controls _ready running, buttons: ", _buttons.size())
	for action in _buttons:
		var button: Button = _buttons[action]
		button.text = _get_action_key_text(action)
		button.pressed.connect(_on_remap_button_pressed.bind(action))
		button.mouse_entered.connect(AudioManager.play_button_hover_sound)

func _get_action_key_text(action: String) -> String:
	for event in InputMap.action_get_events(action):
		if event is InputEventKey:
			if event.physical_keycode != 0:
				return event.as_text_physical_keycode()
			return event.as_text_keycode()
	return "Unassigned"

func _on_remap_button_pressed(action: String) -> void:
	AudioManager.play_button_click_sound()
	if _remap_button:
		_remap_button.text = _get_action_key_text(_remap_action)
	_remap_action = action
	_remap_button = _buttons[action]
	_remap_button.text = "Press a key..."

func _input(event: InputEvent) -> void:
	if _remap_action == "":
		return
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_ESCAPE or event.keycode == KEY_ESCAPE:
			_cancel_remap()
		else:
			_rebind(event)
		get_viewport().set_input_as_handled()

func _rebind(event: InputEventKey) -> void:
	InputMap.action_erase_events(_remap_action)
	var new_event := InputEventKey.new()
	new_event.physical_keycode = event.physical_keycode
	InputMap.action_add_event(_remap_action, new_event)
	_finish_remap()

func _cancel_remap() -> void:
	_finish_remap()

func _finish_remap() -> void:
	AudioManager.play_button_click_sound()
	_remap_button.text = _get_action_key_text(_remap_action)
	_remap_action = ""
	_remap_button = null
