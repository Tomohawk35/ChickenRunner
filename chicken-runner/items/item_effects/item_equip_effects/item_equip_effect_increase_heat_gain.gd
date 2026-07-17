extends ItemEquipEffect
class_name ItemEquipEffectIncreaseHeatGain

@export var heat_gain : float = 1.0

func activate() -> void:
	PlayerManager.increase_heat_gain_rate(heat_gain)

func deactivate() -> void:
	PlayerManager.increase_heat_gain_rate(-heat_gain)
