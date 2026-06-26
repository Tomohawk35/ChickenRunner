extends Node2D

const CAR_TYPES = [
	preload("res://Cars/redcar.tscn"),
	preload("res://Cars/yellowcar.tscn"),
	preload("res://Cars/greencar.tscn")
]

@export var lanes: Array[Node2D]

@export var speed_randomness: float = 25.0
@export var proximity_check: float = 400.0

func _ready() -> void:
	randomize()

	if lanes.is_empty():
		printerr("No lanes assigned!")
		return

	for i in range(lanes.size()):
		start_lane(i)


func start_lane(lane_index: int) -> void:
	lane_loop(lane_index)


func lane_loop(lane_index: int) -> void:
	var lane = lanes[lane_index]

	while true:
		if GameManager._current_state == GameManager.GameState.PLAYING \
				and can_spawn(lane):
			spawn_car(lane)
		await get_tree().create_timer(lane.spawn_delay).timeout
		if GameManager._current_state == GameManager.GameState.GAME_OVER:
			return


func can_spawn(lane: Node2D) -> bool:
	var spawn_pos = lane.global_position
	for child in get_children():
		if child is CharacterBody2D:
			if abs(child.global_position.y - spawn_pos.y) < 10.0:
				var dx = child.global_position.x - spawn_pos.x
				var dist = abs(dx)
				if dist < proximity_check:
					if lane.move_right and dx > 0:
						return false
					if not lane.move_right and dx < 0:
						return false
	return true


func spawn_car(lane: Node2D) -> void:
	var car_scene = CAR_TYPES.pick_random()

	if car_scene == null:
		return

	var car = car_scene.instantiate()

	if car == null:
		return

	add_child(car)

	car.global_position = lane.global_position

	# Direction
	var dir = Vector2.RIGHT

	if !lane.move_right:
		dir = Vector2.LEFT

	car.set_direction(dir)

	# Speed
	var final_speed = lane.lane_speed

	final_speed += randf_range(
		-speed_randomness,
		speed_randomness
	)

	car.set_speed(final_speed)
