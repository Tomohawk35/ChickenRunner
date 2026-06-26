extends CharacterBody2D
class_name MovingObject

@export var speed : float = 300.0

var direction : Vector2 = Vector2.RIGHT
var has_entered_screen : bool = false

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(_delta: float) -> void:
	velocity = direction.normalized() * speed
	
	move_and_slide()
	
	#if sprite:
		#sprite.flip_h = (direction == Vector2.LEFT)


func set_direction(new_direction: Vector2):
	direction = new_direction
	
	if sprite:
		sprite.flip_h = (direction == Vector2.LEFT)


func set_speed(new_speed: float):
	speed = new_speed


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	has_entered_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if has_entered_screen:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Chicken:
		GameManager.Hit.emit()
