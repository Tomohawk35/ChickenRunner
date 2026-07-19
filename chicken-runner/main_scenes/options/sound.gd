extends PanelContainer

const MASTER_BUS := 0
const MUSIC_BUS := 1
const SFX_BUS := 2

@onready var master_slider: HSlider = $MarginContainer/VBoxContainer/Master/HSlider
@onready var master_mute: CheckBox = $MarginContainer/VBoxContainer/Master/CheckBox
@onready var music_slider: HSlider = $MarginContainer/VBoxContainer/Music/HSlider
@onready var music_mute: CheckBox = $MarginContainer/VBoxContainer/Music/CheckBox
@onready var sfx_slider: HSlider = $MarginContainer/VBoxContainer/SFX/HSlider
@onready var sfx_mute: CheckBox = $MarginContainer/VBoxContainer/SFX/CheckBox

func _ready() -> void:
	_init_bus_controls(MASTER_BUS, master_slider, master_mute)
	_init_bus_controls(MUSIC_BUS, music_slider, music_mute)
	_init_bus_controls(SFX_BUS, sfx_slider, sfx_mute)

	master_slider.value_changed.connect(_on_volume_changed.bind(MASTER_BUS))
	music_slider.value_changed.connect(_on_volume_changed.bind(MUSIC_BUS))
	sfx_slider.value_changed.connect(_on_volume_changed.bind(SFX_BUS))

	master_mute.toggled.connect(_on_mute_toggled.bind(MASTER_BUS))
	music_mute.toggled.connect(_on_mute_toggled.bind(MUSIC_BUS))
	sfx_mute.toggled.connect(_on_mute_toggled.bind(SFX_BUS))

func _init_bus_controls(bus: int, slider: HSlider, mute: CheckBox) -> void:
	slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus)) * 100.0
	mute.button_pressed = AudioServer.is_bus_mute(bus)

func _on_volume_changed(value: float, bus: int) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100.0))

func _on_mute_toggled(muted: bool, bus: int) -> void:
	AudioServer.set_bus_mute(bus, muted)
	AudioManager.play_button_click_sound()
