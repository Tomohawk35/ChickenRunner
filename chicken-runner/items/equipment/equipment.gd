extends Item
class_name Equipment

@export var equip_effects : Array[ItemEquipEffect] = []
@export var use_effects : Array[ItemUseEffect] = []
@export var usage_type : UsageType

func equip() -> void:
	for effect in equip_effects:
		effect.activate()

func unequip() -> void:
	for effect in equip_effects:
		effect.deactivate()

func use() -> void:
	if usage_type and usage_type.get_availability():
		for effect in use_effects:
			effect.use()
		usage_type.use()

func process(delta: float) -> void:
	if usage_type and usage_type.get_availability() == false:
		usage_type.process(delta)

func get_availability() -> bool:
	if usage_type == null:
		return true
	if usage_type.get_availability():
		return true
	else:
		return false
