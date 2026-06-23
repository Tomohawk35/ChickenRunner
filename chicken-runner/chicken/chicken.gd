extends CharacterBody2D
class_name Chicken

var speed : float = 200.0

func _physics_process(delta: float) -> void:
	var dir : Vector2 = _get_direction()
	velocity = dir.normalized() * speed
	move_and_slide()

func _get_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")
