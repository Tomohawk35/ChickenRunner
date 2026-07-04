@abstract
extends CharacterBody2D
class_name MovingObject

@export var speed : float = 300.0
@export var sprite : Sprite2D

var direction : Vector2 = Vector2.RIGHT
var has_entered_screen : bool = false

#func _ready() -> void:
	#$Area2D.body_entered.connect(_on_area_2d_body_entered)

func _process(_delta: float) -> void:
	if global_position.x > 4000 or global_position.x < -200:
		queue_free()

func _physics_process(_delta: float) -> void:
	velocity = direction.normalized() * speed
	move_and_slide()

func set_initial_position(pos: Vector2) -> void:
	global_position = pos
	
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	
	if sprite:
		sprite.flip_h = (direction == Vector2.LEFT)

func set_speed(new_speed: float):
	speed = new_speed

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body is Chicken:
		#print("I hit the chicken!")
