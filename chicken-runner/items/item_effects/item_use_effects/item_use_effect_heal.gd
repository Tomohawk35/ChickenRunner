extends ItemUseEffect
class_name ItemUseEffectHeal

@export var heal_amount: float = 20.0

func use() -> void:
	PlayerManager.increase_heat(-heal_amount)
