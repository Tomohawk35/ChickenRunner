extends MovingObject
class_name Car

#@export var speed : float = 300.0
#
#var direction : Vector2 = Vector2.RIGHT
#
#@onready var sprite: Sprite2D = $Sprite2D
#
#func _process(_delta: float) -> void:
	#if global_position.x > 2000 or global_position.x < -200:
		#queue_free()
#
#func _physics_process(_delta: float) -> void:
	#velocity = direction.normalized() * speed
	#move_and_slide()
#
#func set_direction(new_direction: Vector2):
	#direction = new_direction
	#if sprite:
		#sprite.flip_h = (direction == Vector2.LEFT)
#
#func set_speed(new_speed: float):
	#speed = new_speed
