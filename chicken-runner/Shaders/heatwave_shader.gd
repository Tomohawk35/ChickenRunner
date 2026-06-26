extends Node2D

@onready var texture_rect: TextureRect = $TextureRect
@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@export var speed: float = 10.0

var elapsed_time: float = 0.0
var max_speed_reached: bool = false
var shader_paused := false


func _physics_process(delta: float) -> void:
	#if GameManager._current_state == GameManager.GameState.GAME_OVER:
	if not shader_paused:
		texture_rect.material.set_shader_parameter(&"speed", 0.0)
		shader_paused = true
	#return
	
	# Increase speed every 2 seconds
	if !max_speed_reached:
		elapsed_time += delta
		
		if elapsed_time >= 2.0:
			if speed < 30:
				speed += 5.0
			else:
				max_speed_reached = true
			
			elapsed_time = 0.0

	#position.y -= speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Chicken:
		GameManager.Hit.emit()
