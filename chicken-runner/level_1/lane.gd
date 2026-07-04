extends Marker2D
class_name SpawnLane

@export var move_right: bool = true
@export var spawn_delay: float = 3.0
@export var lane_speed: float = 200.0

var _spawn_pool : Array[PackedScene] = []
var _proximity_check : float
var _speed_randomness : float

func start_loop(objects: Array[PackedScene], proximity_check: float, speed_randomness: float) -> void:
	_spawn_pool = objects
	_proximity_check = proximity_check
	_speed_randomness = speed_randomness
	while true:
		spawn_car()
		await get_tree().create_timer(spawn_delay + randf_range(-1.0, 1.0)).timeout

	
func spawn_car() -> void:
	var car_scene : PackedScene = _spawn_pool.pick_random()
	if car_scene == null:
		return
	var car : MovingObject = car_scene.instantiate() as MovingObject
	if car == null:
		return
	add_child(car)
	car.global_position = global_position
	
	var dir : Vector2 = Vector2.RIGHT if move_right else Vector2.LEFT
	car.set_direction(dir)
	
	var final_speed = lane_speed + randf_range(-_speed_randomness, _speed_randomness)
	car.set_speed(final_speed)
