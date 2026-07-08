extends ItemEffect
class_name ItemEffectHeal

func activate() -> void:
	PlayerManager.increase_heat(-30)
