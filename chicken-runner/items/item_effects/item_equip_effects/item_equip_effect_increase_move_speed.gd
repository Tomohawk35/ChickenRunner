extends ItemEquipEffect
class_name ItemEquipEffectIncreaseMoveSpeed

@export var speed_boost : float = 100.0

func activate() -> void:
	PlayerManager.increase_move_speed(speed_boost)

func deactivate() -> void:
	PlayerManager.increase_move_speed(-speed_boost)
	
