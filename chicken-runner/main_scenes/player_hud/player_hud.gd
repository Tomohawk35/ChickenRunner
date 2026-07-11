extends CanvasLayer

@onready var temperature_meter: ProgressBar = %TemperatureMeter
@onready var level_label: Label = %LevelLabel
@onready var pause_menu: Control = $Pause_menu
@onready var pause: Button = $Pause

func _ready() -> void:
	pause_menu.hide()
	pause.pressed.connect(_on_pause_button_pressed)
	pause.mouse_entered.connect(_on_button_hover)
	temperature_meter.value = PlayerManager.heat_level
	PlayerManager.heat_changed.connect(_on_heat_changed)

func _on_heat_changed(value: float) -> void:
	temperature_meter.set_value_no_signal(value)

func _on_pause_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	get_tree().paused = true
	pause_menu.show()
	
func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()
