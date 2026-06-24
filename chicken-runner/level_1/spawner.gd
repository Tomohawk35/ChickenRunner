extends Node2D

const car_types = [
	preload("res://Cars/redcar.tscn"),
	preload("res://Cars/yellowcar.tscn"),
	preload("res://Cars/greencar.tscn")
]

@export var spawn_points: Array[Node2D] 
@export_category("Spawn Time")
@export var start_range: float = 1.0
@export var end_range: float = 1.5

func _ready() -> void:
	spawn_car()

func spawn_car() -> void:
	if spawn_points.is_empty():
		printerr("Error: No spawn points assigned in the Inspector!")
		return

	var random_point_index = randi() % spawn_points.size()
	var random_point = spawn_points[random_point_index]

	var random_car_scene = car_types.pick_random()
	var new_car = random_car_scene.instantiate()

	if not new_car:
		print("Failed to instantiate a car scene.")
		return

	new_car.global_position = random_point.global_position
	
	if random_point_index % 2 == 0:
		if "flip" in new_car:
			new_car.flip = true
	else:
		if "flip" in new_car:
			new_car.flip = false
			
	add_child(new_car)
	
	var timer = get_tree().create_timer(randf_range(start_range, end_range))
	await timer.timeout
	spawn_car()
