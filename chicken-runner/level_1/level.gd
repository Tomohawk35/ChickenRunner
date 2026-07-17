extends Node2D
class_name Level

const HEAT_GAIN_INTERVAL : float = 1.0

@export var base_heat_gain_rate : float = 2.0

@onready var chicken: Chicken = $Chicken
@onready var player_hud: CanvasLayer = $PlayerHud

var _heat_gain_rate : float
var _elapsed_time : float = 0.0

func _ready() -> void:
	_calculate_heat_gain(PlayerManager.heat_gain_rate)
	PlayerManager.heat_gain_rate_changed.connect(_on_heat_gain_rate_changed)
	chicken.completion_zone_entered.connect(_on_completion_zone_entered)

func _process(delta: float) -> void:
	_elapsed_time += delta
	if _elapsed_time >= HEAT_GAIN_INTERVAL:
		_elapsed_time = 0.0
		if PlayerManager.is_cooling:
			PlayerManager.increase_heat(-_heat_gain_rate)
		else:
			PlayerManager.increase_heat(_heat_gain_rate)

func _on_heat_gain_rate_changed(new_heat_gain_rate: float) -> void:
	_calculate_heat_gain(new_heat_gain_rate)

func _calculate_heat_gain(player_heat_gain_modifier: float) -> void:
	_heat_gain_rate = base_heat_gain_rate + player_heat_gain_modifier

func _on_completion_zone_entered() -> void:
	AudioManager.play_chicken_cockledoodledoo_victory_sound()
	if GameManager.current_level != GameManager.LAST_LEVEL:
		player_hud.show_reward_scene()
	else:
		GameManager.next_level()
