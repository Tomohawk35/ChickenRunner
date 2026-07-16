extends Node

#signal heat_changed(value: float)
signal scene_loaded

const FADE_DURATION : float = 0.3
const LAST_LEVEL : int = 3
const LOAD_SCREEN_MIN_DURATION : float = 3.0
const CONSUMABLES_PATH : String = "res://items/consumables/resources/"
const EQUIPMENT_PATH : String = "res://items/equipment/resources/"

@onready var joke: Label = $CanvasLayer/joke

var current_level : int = 0
var consumables : Array[Consumable] = []
var equipment : Array[Equipment] = []

var jokes: Array[String] = [
	# Dad chicken jokes
	"Why did the chicken join a band? Because it had the drumsticks!",
	"What do you call a chicken that crosses the road, rolls in the mud, and crosses back? A dirty double-crosser!",
	"Why don't chickens wear pants? Because their peckers are on their faces!",
	"How did the chicken with no legs cross the road? KFC bucket.",
	"What day do chickens hate the most? Fry-day.",
	
	# Chicken facts
	"Did you know? Chickens can remember over 100 different faces! They're smarter than you think.",
	"Fun fact: A chicken's heart beats 300-400 times per minute - faster than a hummingbird!",
	"Chickens have a complex form of communication with over 30 distinct vocalizations ",
	"Chickens are descended from the red junglefowl of Southeast Asia, and they were first domesticated over 8,000 years ago",
	"The longest recorded flight by a chicken is 13 seconds — not exactly an eagle, but hey, they try!"
]
var _game_scenes : Dictionary[String, String] = {
	"main_menu": "uid://ccghfwhfqeydf",
	"game_over": "uid://cilxyeywaty0j",
	"level_1": "uid://bvj4u3smrfbcr",
	"level_2": "uid://bvj4u3smrfbcr",
	"level_3": "uid://bvj4u3smrfbcr",
	"victory": "uid://dqt2r7qcy7pcn",
	"options":"uid://c040d24e1b1vi"
}

@onready var _tree : SceneTree = get_tree()
@onready var _root : Node = _tree.get_root()
@onready var _current_scene : Node = _tree.current_scene
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _ready() -> void:
	#if OS.is_debug_build():
		#change_scene("level_01")
	#Hit.connect(_on_hit)
	#joke.hide()
	_load_resources_from_folder(CONSUMABLES_PATH, consumables)
	_load_resources_from_folder(EQUIPMENT_PATH, equipment)

func _fade_out() -> Tween:
	var tween : Tween = create_tween()
	tween.tween_property(color_rect, "color:a", 255, FADE_DURATION)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(joke, "modulate:a", 255, FADE_DURATION)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	return tween

func _fade_in() -> Tween:
	var tween : Tween = create_tween()
	tween.tween_property(color_rect, "color:a", 0, FADE_DURATION)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(joke, "modulate:a", 0, FADE_DURATION)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	return tween

func _load_resources_from_folder(path: String, target_array: Array) -> void:
	for file in DirAccess.get_files_at(path):
		target_array.append(load_asset(path + file))

static func load_asset(path: String) -> Resource:
	if OS.has_feature("export"):
		if not path.ends_with(".remap"):
			return load(path)
		
		var __config_file = ConfigFile.new()
		__config_file.load(path)
		
		# Load the remapped file
		var __remapped_file_path = __config_file.get_value("remap", "path")
		__config_file = null
		return load(__remapped_file_path)
	else:
		return load(path)

func _load_scene_resource(path: Variant) -> Resource:
	if path is PackedScene:
		return path
	return ResourceLoader.load(path, "PackedScene")

func change_scene(scene: String) -> void:
	if !_game_scenes.has(scene):
		return
	
	_tree.paused = true
	joke.text = jokes.pick_random()
	joke.show()
	
	var start_time : int = Time.get_ticks_msec()

	await _fade_out().finished
	_current_scene.queue_free()
	var next_scene : PackedScene = _load_scene_resource(_game_scenes[scene])
	_current_scene = next_scene.instantiate()
	_root.add_child(_current_scene)
	
	var load_duration : int = Time.get_ticks_msec() - start_time

	await _tree.create_timer(clamp(LOAD_SCREEN_MIN_DURATION - (load_duration / 1000.0), 0.0, LOAD_SCREEN_MIN_DURATION)).timeout
	joke.hide()
	await _fade_in().finished
	scene_loaded.emit() # TODO: NEED TO LISTEN FOR SIGNAL BEFORE STARTING LEVELS
	_tree.paused = false

func get_random_consumable() -> Consumable:
	return consumables.pick_random()

func get_random_equipment() -> Equipment:
	return equipment.pick_random()

func new_game() -> void:
	_tree.paused = false
	current_level = 1
	#heat_level = 0.0
	change_scene("level_" + str(current_level))

func next_level() -> void:
	if current_level == LAST_LEVEL:
		change_scene("victory")
	current_level += 1
	#heat_level = 0.0
	change_scene("level_" + str(current_level))

func game_over() -> void:
	change_scene("game_over")

#func increase_heat(value: float) -> void:
	#heat_level += value
	#heat_changed.emit(heat_level)
	#if heat_level >= 100:
		#game_over()
#
#func decrease_heat(value: float) -> void:
	#heat_level -= value
	#if heat_level < 0:
		#heat_level = 0
	#heat_changed.emit(heat_level)

#func cooling_ref() -> void:
	#_cooling_count += 1
#
#func cooling_unref() -> void:
	#_cooling_count = maxi(_cooling_count - 1, 0)
