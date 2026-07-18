extends UsageType
class_name UsageTypeCooldown

@export var cooldown : float = 10.0

var _cooldown_time : float = 0.0

func use() -> void:
	_cooldown_time = cooldown

func get_availability() -> bool:
	if _cooldown_time <= 0.0:
		return true
	else:
		return false

func process(delta: float) -> void:
	if _cooldown_time > 0.0:
		_cooldown_time -= delta

func get_cooldown_time() -> float:
	return _cooldown_time
