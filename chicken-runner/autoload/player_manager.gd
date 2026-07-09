## GLOBAL - PlayerManager
extends Node

signal heat_changed(new_heat_level: float)
signal consumable_changed

var consumable : Consumable = load("uid://c3nv13iw6iay3")
var power_ups : Array = []
var selected_power_up : int = 0


var heat_gain_rate : float = 2.0
var heat_level : float = 0.0 : 
	set(v):
		heat_level = v
		heat_changed.emit(heat_level)

var _cooling_count : int = 0
var is_cooling : bool:
	get: return _cooling_count > 0

func reset_heat() -> void:
	heat_level = 0.0
	
func increase_heat(value: float) -> void:
	heat_level = clampf(heat_level + value, 0.0, 100.0)
	if heat_level >= 100.0:
		GameManager.game_over()

func increase_heat_gain(value: float) -> void:
	heat_gain_rate += value

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


func cooling_ref() -> void:
	_cooling_count += 1

func cooling_unref() -> void:
	_cooling_count = maxi(_cooling_count - 1, 0)
