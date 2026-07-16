extends CanvasLayer


@onready var temperature_meter: ProgressBar = %TemperatureMeter
@onready var level_label: Label = %LevelLabel
@onready var pause_menu: Control = $PauseMenu
@onready var pause: Button = $Pause
<<<<<<< Updated upstream
@onready var instructions: Control = $Instructions

func _ready() -> void:
	pause_menu.hide()
	instructions.hide()
=======
@onready var equipment_slot_container: HBoxContainer = %EquipmentSlotContainer
@onready var level_complete_screen: Control = %LevelCompleteScreen

func _ready() -> void:
	pause_menu.hide()
	level_complete_screen.hide()
>>>>>>> Stashed changes
	pause.pressed.connect(_on_pause_button_pressed)
	pause.mouse_entered.connect(_on_button_hover)
	temperature_meter.value = PlayerManager.heat_level
	PlayerManager.heat_changed.connect(_on_heat_changed)
<<<<<<< Updated upstream
	GameManager.scene_loaded.connect(_on_scene_loaded)

func _on_scene_loaded() -> void:
	await get_tree().process_frame
	instructions.open()
=======
	level_label.text = "Level " + str(GameManager.current_level)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if !level_complete_screen.visible:
			if !pause_menu.visible:
				AudioManager.play_button_hover_sound()
				pause_menu.open()
			else:
				AudioManager.play_button_click_sound()
				pause_menu.close()
>>>>>>> Stashed changes

func _on_heat_changed(value: float) -> void:
	temperature_meter.set_value_no_signal(value)

func _on_pause_button_pressed() -> void:
	AudioManager.play_button_click_sound()
	get_tree().paused = true
	pause_menu.show()
	
func _on_button_hover() -> void:
	AudioManager.play_button_hover_sound()

#func _update_equipment_slots() -> void:
	#for child in equipment_slot_container.get_children():
		#child

func show_reward_scene() -> void:
	get_tree().paused = true
	level_complete_screen.open()
