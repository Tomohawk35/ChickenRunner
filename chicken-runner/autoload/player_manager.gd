## GLOBAL - PlayerManager
extends Node

signal heat_changed(new_heat_level: float)
signal heat_gain_rate_changed(new_heat_gain_rate: float)
signal move_speed_changed(new_move_speed: float)
signal consumable_changed
signal equipment_changed
signal chicken_died

var consumable : Consumable
var equipment : Array[Equipment] = []
var selected_equipment : int = 0


var heat_gain_rate : float = 0.0 : 
	set(v):
		heat_gain_rate = v
		heat_gain_rate_changed.emit(heat_gain_rate)

var heat_level : float = 0.0 : 
	set(v):
		heat_level = v
		heat_changed.emit(heat_level)

var move_speed : float = 0.0 : 
	set(v):
		move_speed = v
		move_speed_changed.emit(move_speed)

var _cooling_count : int = 0
var is_cooling : bool:
	get: return _cooling_count > 0

var is_immune : bool = false
var immunity_duration : float = 0.0

func _physics_process(delta: float) -> void:
	if is_immune:
		immunity_duration -= delta
		if immunity_duration <= 0.0:
			immunity_duration = 0.0
			is_immune = false

func initialize_player() -> void:
	reset_heat()
	heat_gain_rate = 0.0
	move_speed = 0.0
	consumable = load("uid://e8eftyo18lyi")
	equipment.clear()
	selected_equipment = 0

func reset_heat() -> void:
	heat_level = 0.0
	
func increase_heat(value: float) -> void:
	heat_level = clampf(heat_level + value, 0.0, 100.0)
	if heat_level >= 75.0:
		AudioManager.play_sizzle_effect()
	else:
		AudioManager.stop_sizzle_effect()
	if heat_level >= 100.0:
		AudioManager.stop_sizzle_effect()
		chicken_died.emit()

func increase_heat_gain_rate(value: float) -> void:
	heat_gain_rate += value

func increase_move_speed(value: float) -> void:
	move_speed += value

func get_current_consumable() -> Consumable:
	return consumable

func pick_up_consumable(item: Consumable) -> void:
	if !item:
		return
	if consumable:
		item.consume()
	else:
		consumable = item
		consumable_changed.emit()

func use_current_consumable() -> void:
	if consumable:
		consumable.consume()
		consumable = null
		consumable_changed.emit()

func pickup_equipment(e: Equipment) -> void:
	if equipment.has(e):
		return # TODO: Upgrade equipment if you get duplicates
	equipment.append(e)
	equipment_changed.emit()

func use_equipment() -> void:
	if equipment.size() == 0:
		return
	if equipment[selected_equipment]:
		equipment[selected_equipment].use()

func switch_equipment() -> void:
	if equipment.size() <= 1:
		return
	equipment[selected_equipment].unequip()
	selected_equipment += 1
	if selected_equipment > equipment.size() - 1:
		selected_equipment = 0
	equipment[selected_equipment].equip()
	equipment_changed.emit()

func get_next_equipment(increment: int = 0) -> Equipment:
	if equipment.size() == 0:
		return
	if increment >= equipment.size():
		return null
	var slot_number : int = (selected_equipment + increment) % equipment.size()
	return equipment[slot_number]

func cooling_ref() -> void:
	_cooling_count += 1

func cooling_unref() -> void:
	_cooling_count = maxi(_cooling_count - 1, 0)

func start_immunity(duration: float) -> void:
	immunity_duration = duration
	is_immune = true
