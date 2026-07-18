extends Area2D
class_name Projectile


var _velocity : Vector2

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	translate(_velocity * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("moving_objects"):
		body.queue_free() 
		queue_free()

func set_velocity(speed: float, dir: Vector2) -> void:
	_velocity = speed * dir
	_set_projectile_direction(dir)

func _set_projectile_direction(dir: Vector2) -> void:
	match dir:
		Vector2.UP:
			pass
		Vector2.RIGHT:
			rotation_degrees += 90.0
		Vector2.LEFT:
			rotation_degrees -= 90.0
		Vector2.DOWN:
			rotation_degrees += 180.0
