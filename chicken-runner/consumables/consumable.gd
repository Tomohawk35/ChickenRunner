extends Resource
class_name Consumable

@export var item_name : String = "New Consumable"
@export var sprite : Texture2D
@export var effects : Array[ItemEffect] = []

func consume() -> void:
	for effect in effects:
		effect.activate()
