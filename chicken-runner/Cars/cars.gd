extends CharacterBody2D

@export var speed : float = 300.0
@export var flip : bool = false  # Default to false (Right)

@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(_delta: float) -> void:
	# 1. Determine direction based on flip
	var target_dir : Vector2 = Vector2.RIGHT
	
	if flip:
		target_dir = Vector2.LEFT
		
	# 2. Apply velocity
	velocity = target_dir.normalized() * speed
	move_and_slide()
	
	# 3. Update the sprite's visual flip
	if sprite:
		sprite.flip_h = flip


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
