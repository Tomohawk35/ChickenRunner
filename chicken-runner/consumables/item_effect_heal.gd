extends ItemEffect
class_name ItemEffectHeal

@export var heal_amount: float = 20.0

func activate() -> void:
	PlayerManager.increase_heat(-heal_amount)
