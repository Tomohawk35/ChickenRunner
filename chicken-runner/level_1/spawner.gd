extends Node2D
class_name Spawner

enum MovingObjects { CARS }

# Hopefully setting it up this way makes it easier to use for different themes of objects
const SPAWN_OBJECTS : Dictionary[MovingObjects, Array] = {
	MovingObjects.CARS : [
		"uid://cui4ytqb2hhgq",
		"uid://c1w7ji2vf5rug",
		"uid://ccfgae2dvkr73"
	]
}

@export var spawnable_objects : MovingObjects = MovingObjects.CARS
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
	for s in SPAWN_OBJECTS[spawnable_objects]:
		object_scenes.append(load(s) as PackedScene)
