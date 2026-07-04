extends CharacterBody2D
class_name Chicken

var speed : float = 300.0

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.area_entered.connect(_on_area_entered)

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
		print("Completion Zone reached!")
		GameManager.change_scene("victory")

func _get_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")
