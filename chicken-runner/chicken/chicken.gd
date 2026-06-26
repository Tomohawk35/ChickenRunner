extends CharacterBody2D
class_name Chicken

var speed : float = 200.0

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)

func _physics_process(_delta: float) -> void:
	var dir : Vector2 = _get_direction()
	velocity = dir.normalized() * speed
	move_and_slide()

func _get_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")
