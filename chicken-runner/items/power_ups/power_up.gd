extends Resource
class_name Equipment

@export var equipment_name : String = "New Equipment"
@export var description : String = "Description of the New Equipment"
@export var icon : Texture2D

@export var equip_effects : Array[ItemEffect] = []
@export var use_effects : Array[ItemEffect] = []

func equip() -> void:
	for effect in equip_effects:
		effect.activate()

func unequip() -> void:
	for effect in equip_effects:
		effect.deactivate()

func use() -> void:
	for effect in use_effects:
		effect.activate()
