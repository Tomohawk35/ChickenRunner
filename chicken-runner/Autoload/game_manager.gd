extends Node

signal Hit

enum GameState { MAIN_MENU, PLAYING, GAME_OVER }

const FADE_DURATION : float = 0.2

var _current_state: GameState
#var _current_scene : Node
var _game_scenes : Dictionary[String, String] = {
	"main_menu": "uid://ccghfwhfqeydf",
	"game_over": "uid://cilxyeywaty0j",
	"level_01": "uid://bvj4u3smrfbcr"
}

@onready var _tree := get_tree()
@onready var _root := _tree.get_root()
@onready var _current_scene := _tree.current_scene

@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _ready() -> void:
	#if OS.is_debug_build():
		#change_scene("level_01")
	
	Hit.connect(_on_hit)

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

func _on_hit() -> void:
	_current_state = GameState.GAME_OVER

func _load_scene_resource(path: Variant) -> Resource:
	if path is PackedScene:
		return path
	return ResourceLoader.load(path, "PackedScene")

func change_scene(scene: String) -> void:
	if !_game_scenes.has(scene):
		return
	await _fade_out().finished
	_current_scene.queue_free()
	var next_scene : PackedScene = _load_scene_resource(_game_scenes[scene])
	_current_scene = next_scene.instantiate()
	_root.add_child(_current_scene)
	await _fade_in().finished
