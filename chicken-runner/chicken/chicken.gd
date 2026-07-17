extends CharacterBody2D
class_name Chicken

signal completion_zone_entered

const STARTING_SPEED : float = 250.0

var speed : float = 250.0

@onready var area_2d: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.area_entered.connect(_on_area_entered)
	PlayerManager.reset_heat()
	_update_speed(PlayerManager.move_speed)
	PlayerManager.move_speed_changed.connect(_update_speed)
	PlayerManager.chicken_died.connect(_on_chicken_heat_death)

func _physics_process(_delta: float) -> void:
	var dir : Vector2 = _get_direction()
	velocity = dir.normalized() * speed
	move_and_slide()

func _on_body_entered(body: Node2D) -> void:
	if body is MovingObject:
		AudioManager.play_chicken_hit_sound()
		GameManager.change_scene("game_over")

func _on_area_entered(area: Area2D) -> void:
	if area is CompletionZone:
		completion_zone_entered.emit()

func _on_chicken_heat_death() -> void:
	animation_player.play("death")
	await animation_player.animation_finished
	GameManager.game_over()

func _get_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_consumable"):
		PlayerManager.use_current_consumable()
	elif event.is_action_pressed("use_equipment"):
		PlayerManager.use_equipment()
	elif event.is_action_pressed("toggle_equipment"):
		PlayerManager.switch_equipment()

func _update_speed(s: float) -> void:
	speed = STARTING_SPEED + s
