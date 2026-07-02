extends Node

#signal Hit
signal heat_changed(value: float)

enum GameState { MAIN_MENU, PLAYING, GAME_OVER }

const FADE_DURATION : float = 0.6
const LAST_LEVEL : int = 1

@onready var joke: Label = $CanvasLayer/joke

var current_level : int = 0
var heat_level : float = 0.0
var jokes: Array[String] = [
	# Dad chicken jokes
	"Why did the chicken join a band? Because it had the drumsticks!",
	"What do you call a chicken that crosses the road, rolls in the mud, and crosses back? A dirty double-crosser!",
	"Why don't chickens wear pants? Because their peckers are on their faces!",
	# Chicken facts
	"Did you know? Chickens can remember over 100 different faces! They're smarter than you think.",
	"Fun fact: A chicken's heart beats 300-400 times per minute - faster than a hummingbird!"
]
#var _current_state: GameState
var _game_scenes : Dictionary[String, String] = {
	"main_menu": "uid://ccghfwhfqeydf",
	"game_over": "uid://cilxyeywaty0j",
	"level_1": "uid://bvj4u3smrfbcr",
	"victory": "uid://dqt2r7qcy7pcn"
}

@onready var _tree : SceneTree = get_tree()
@onready var _root : Node = _tree.get_root()
@onready var _current_scene : Node = _tree.current_scene
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _ready() -> void:
	#if OS.is_debug_build():
		#change_scene("level_01")
	#Hit.connect(_on_hit)
	joke.hide()

func _fade_out() -> Tween:
	var tween : Tween = create_tween()
	tween.tween_property(color_rect, "color:a", 255, FADE_DURATION)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	return tween

func _fade_in() -> Tween:
	var tween : Tween = create_tween()
	tween.tween_property(color_rect, "color:a", 0, FADE_DURATION)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	return tween


func _load_scene_resource(path: Variant) -> Resource:
	if path is PackedScene:
		return path
	return ResourceLoader.load(path, "PackedScene")

func change_scene(scene: String) -> void:
	if !_game_scenes.has(scene):
		return
	joke.text = jokes.pick_random()
	joke.show()

	await _fade_out().finished
	_current_scene.queue_free()
	var next_scene : PackedScene = _load_scene_resource(_game_scenes[scene])
	_current_scene = next_scene.instantiate()
	_root.add_child(_current_scene)
	joke.hide()
	await _fade_in().finished

func new_game() -> void:
	current_level = 1
	heat_level = 0.0
	change_scene("level_" + str(current_level))

func next_level() -> void:
	if current_level == LAST_LEVEL:
		change_scene("victory")
	current_level += 1
	heat_level = 0.0
	change_scene("level_" + str(current_level))

func game_over() -> void:
	change_scene("game_over")

func increase_heat(value: float) -> void:
	heat_level += value
	heat_changed.emit(heat_level)
	if heat_level >= 100:
		game_over()
