extends ItemUseEffect
class_name ItemUseEffectImmunity

@export var duration : float = 4.0

func use() -> void:
	PlayerManager.start_immunity(duration)
