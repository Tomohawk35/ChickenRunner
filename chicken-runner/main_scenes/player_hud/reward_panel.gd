extends PanelContainer
class_name RewardPanel

signal pressed(acquired_item: Item)

const UI_FLAT_FRAME_01A = preload("uid://pdbpgcbyemid")
const UI_FLAT_FRAME_02A = preload("uid://b8se0m8cyhoce")
const UI_FLAT_FRAME_03A = preload("uid://dl37msvr6qgnn")

var item : Item

@export var name_label: Label
@export var texture_rect: TextureRect
@export var item_type_label: Label
@export var description_label: Label

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _gui_input(event: InputEvent) -> void:
	if !item:
		return
	if event.is_action_pressed("click"):
		AudioManager.play_button_click_sound()
		pressed.emit(item)
		if item is Consumable:
			PlayerManager.pick_up_consumable(item)
		elif item is Equipment:
			PlayerManager.pickup_equipment(item)
		# TODO: Load next level

func _on_mouse_entered() -> void:
	AudioManager.play_button_hover_sound()

func _on_mouse_exited() -> void:
	pass

func set_item(i: Item) -> void:
	item = i
	name_label.text = item.item_name
	texture_rect.texture = item.icon
	item_type_label.text = "Consumable" if item is Consumable else "Equipment"
	description_label.text = item.description
