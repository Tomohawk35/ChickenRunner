extends CanvasLayer

const HEAT_GAIN_INTERVAL : float = 1.0
const HEAT_GAIN_AMOUNT : float = 5.0

var _elapsed_time : float = 0.0

@onready var temperature_meter: ProgressBar = %TemperatureMeter
@onready var level_label: Label = %LevelLabel

func _ready() -> void:
	temperature_meter.value = GameManager.heat_level
	GameManager.heat_changed.connect(_on_heat_changed)

func _process(delta: float) -> void:
	_elapsed_time += delta
	if _elapsed_time >= HEAT_GAIN_INTERVAL:
		_elapsed_time = 0.0
		GameManager.increase_heat(HEAT_GAIN_AMOUNT)

func _on_heat_changed(value: float) -> void:
	temperature_meter.set_value_no_signal(value)
