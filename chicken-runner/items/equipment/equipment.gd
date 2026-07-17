extends Item
class_name Equipment

@export var equip_effects : Array[ItemEquipEffect] = []
@export var use_effects : Array[ItemUseEffect] = []
@export var cooldown : float = 10.0
@export var one_shot : bool = false

func equip() -> void:
	for effect in equip_effects:
		effect.activate()

func unequip() -> void:
	for effect in equip_effects:
		effect.deactivate()

func use() -> void:
	for effect in use_effects:
		effect.use()
