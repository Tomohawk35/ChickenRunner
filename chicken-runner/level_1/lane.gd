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
		if can_spawn():
			spawn_car()
		await get_tree().create_timer(spawn_delay + randf_range(-1.0, 1.0)).timeout

func can_spawn() -> bool:
	#for obj in _object_pool:
		#if abs(obj.global_position.y - global_position.y) < 10.0:
			#var dx = obj.global_position.x - global_position.x
			#var dist = abs(dx)
			#if dist < _proximity_check:
				#if move_right and dx > 0:
					#return false
				#if not move_right and dx < 0:
					#return false
	return true
	
	#for child in get_children():
		#if child is CharacterBody2D:
			#if abs(child.global_position.y - spawn_pos.y) < 10.0:
				#var dx = child.global_position.x - spawn_pos.x
				#var dist = abs(dx)
				#if dist < proximity_check:
					#if lane.move_right and dx > 0:
						#return false
					#if not lane.move_right and dx < 0:
						#return false
	#return true


func spawn_car() -> void:
	var car_scene : PackedScene = _spawn_pool.pick_random()
	if car_scene == null:
		return
	var car : MovingObject = car_scene.instantiate() as MovingObject
	if car == null:
		return
	car.global_position = global_position
	
	# Direction
	var dir : Vector2 = Vector2.RIGHT if move_right else Vector2.LEFT
	car.set_direction(dir)
	
	# Speed
	var final_speed = lane_speed + randf_range(-_speed_randomness, _speed_randomness)
	car.set_speed(final_speed)
	add_child(car)
