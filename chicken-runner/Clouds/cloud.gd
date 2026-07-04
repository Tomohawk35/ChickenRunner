extends MovingObject

@export var move_right: bool = true
@export var ground_y: float = 460.0
@export var wrap_width: float = 1400.0

@onready var shadow_visual: Sprite2D = $ShadowVisual
@onready var shadow_zone: Area2D = $ShadowZone

func _ready() -> void:
	var offset_y = ground_y - global_position.y
	shadow_visual.position.y = offset_y
	shadow_zone.position.y = offset_y
	shadow_zone.body_entered.connect(_on_shadow_zone_body_entered)
	shadow_zone.body_exited.connect(_on_shadow_zone_body_exited)
	set_direction(Vector2.RIGHT if move_right else Vector2.LEFT)

func _physics_process(_delta: float) -> void:
	pass

func _process(delta: float) -> void:
	var dir = 1 if move_right else -1
	position.x += speed * dir * delta
	if position.x > wrap_width:
		position.x = -wrap_width
	elif position.x < -wrap_width:
		position.x = wrap_width

func _on_shadow_zone_body_entered(_body: Node) -> void:
	GameManager.cooling_ref()

func _on_shadow_zone_body_exited(_body: Node) -> void:
	GameManager.cooling_unref()
