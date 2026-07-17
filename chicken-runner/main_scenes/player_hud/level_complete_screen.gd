extends Control
class_name LevelCompleteScreen

const REWARD_PANEL : PackedScene = preload("uid://hrcwocxltfy")

@onready var reward_container: HBoxContainer = %RewardContainer

func open() -> void:
	for child in reward_container.get_children():
		child.queue_free()
	var panel_scene : RewardPanel
	for i in range(1 + GameManager.current_level):
		panel_scene = REWARD_PANEL.instantiate()
		var num : float = randf()
		var item : Item
		if num < 0.5:
			item = GameManager.get_random_consumable()
		else:
			item = GameManager.get_random_equipment()
		panel_scene.set_item(item)
		reward_container.add_child(panel_scene)
		panel_scene.pressed.connect(_on_reward_panel_pressed)
	show()

func _on_reward_panel_pressed(selected_item: Item) -> void:
	if selected_item is Consumable:
		PlayerManager.pick_up_consumable(selected_item)
	elif selected_item is Equipment:
		PlayerManager.pickup_equipment(selected_item)
	GameManager.next_level()
