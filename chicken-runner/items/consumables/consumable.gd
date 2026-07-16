extends Item
class_name Consumable


@export var effects : Array[ItemUseEffect] = []

func consume() -> void:
	for effect in effects:
		effect.use()
