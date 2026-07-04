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
		spawn_object()
		await get_tree().create_timer(spawn_delay + randf_range(-1.0, 1.0)).timeout

	
func spawn_object() -> void:
	var obj_packed : PackedScene = _spawn_pool.pick_random()
	if obj_packed == null:
		return
	var obj : MovingObject = obj_packed.instantiate()
	obj.set_initial_position(global_position)
	var dir : Vector2 = Vector2.RIGHT if move_right else Vector2.LEFT
	obj.set_direction(dir)
	var final_speed = obj.speed + randf_range(-_speed_randomness, _speed_randomness)
	obj.set_speed(final_speed)
	add_child(obj)
	#obj.global_position = global_position
	
	
