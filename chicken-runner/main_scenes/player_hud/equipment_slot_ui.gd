extends TextureRect
class_name EquipmentSlotUI

const UI_FLAT_FRAME_SLOT_01B = preload("uid://drwse2c6im583")
const UI_FLAT_FRAME_SLOT_03A = preload("uid://qxd13btjchgy")

@export var slot : int = 0

var _equipment : Equipment

@onready var equipment_slot_ui: TextureRect = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cooldown_panel: Panel = %CooldownPanel
@onready var label: Label = $Label


func _ready() -> void:
	if slot == 0:
		equipment_slot_ui.texture = UI_FLAT_FRAME_SLOT_03A
	else:
		equipment_slot_ui.texture = UI_FLAT_FRAME_SLOT_01B
	update_equipment()
	PlayerManager.equipment_changed.connect(update_equipment)

func _process(_delta: float) -> void:
	if _equipment == null:
		cooldown_panel.show()
		label.hide()
		return
	if _equipment.get_availability():
		cooldown_panel.hide()
		label.hide()
	else:
		cooldown_panel.show()
		if _equipment.usage_type is UsageTypeCooldown:
			label.text = str(ceil(_equipment.usage_type.get_cooldown_time()))
			label.show()
		else:
			label.text = "X"
			label.show()

func update_equipment() -> void:
	_equipment = PlayerManager.get_next_equipment(slot)
	if _equipment:
		sprite_2d.texture = _equipment.icon
	else:
		sprite_2d.texture = null
