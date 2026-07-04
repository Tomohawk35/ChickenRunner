extends Node2D
class_name Spawner

enum MovingObjects { CARS, CLOUDS }

# Hopefully setting it up this way makes it easier to use for different themes of objects
const SPAWN_OBJECTS : Dictionary[MovingObjects, Array] = {
	MovingObjects.CARS : [
		#"uid://cui4ytqb2hhgq",
		"uid://c1w7ji2vf5rug",
		#"uid://ccfgae2dvkr73"
	], 
	MovingObjects.CLOUDS : [
		"uid://dy2p420jn8qx6"
	]
}

@export var spawnable_objects : Array[MovingObjects] = [MovingObjects.CARS]
@export var speed_randomness: float = 25.0

var lanes: Array[SpawnLane]

func _ready() -> void:
	randomize()
	
	_compile_lanes()
	_start_lanes()

func _compile_lanes() -> void:
	lanes.clear()
	for child in get_children():
		if child is SpawnLane:
			lanes.append(child)

func _start_lanes() -> void:
	var object_scenes : Array[PackedScene] = []
	for object_type in spawnable_objects:
		for object_scene in SPAWN_OBJECTS[object_type]:
			object_scenes.append(load(object_scene) as PackedScene)
	for lane in lanes:
		lane.start_loop(object_scenes, 400.0, speed_randomness)
