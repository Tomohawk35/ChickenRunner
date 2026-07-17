extends TextureRect
class_name ConsumableSlotUI

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	update_item()
	PlayerManager.consumable_changed.connect(update_item)

func update_item() -> void:
	var c : Consumable = PlayerManager.get_current_consumable()
	if c:
		sprite_2d.texture = c.icon
	else:
		sprite_2d.texture = null
