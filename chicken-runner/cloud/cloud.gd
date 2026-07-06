extends MovingObject
class_name Cloud

@export var move_right: bool = true
@export var ground_y: float = 460.0
@export var wrap_width: float = 1400.0

@onready var shadow_visual: Sprite2D = $ShadowVisual
@onready var shadow_zone: Area2D = $ShadowZone

func _ready() -> void:
	shadow_zone.body_entered.connect(_on_shadow_zone_body_entered)
	shadow_zone.body_exited.connect(_on_shadow_zone_body_exited)

func _physics_process(delta: float) -> void:
	super(delta)

func _process(delta: float) -> void:
	super(delta)

func _on_shadow_zone_body_entered(body: Node2D) -> void:
	if body is Chicken:
		GameManager.cooling_ref()

func _on_shadow_zone_body_exited(body: Node2D) -> void:
	if body is Chicken:
		GameManager.cooling_unref()
