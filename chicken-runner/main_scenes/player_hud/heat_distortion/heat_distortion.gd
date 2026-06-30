extends TextureRect
class_name HeatDistortion

var elapsed_time: float = 0.0
var max_speed_reached: bool = false
var shader_paused := false

var gradient_texture : GradientTexture2D
var _point_1_color : Color
var _point_2_color : Color

func _ready() -> void:
	_initialize_heat_distortion()
	GameManager.heat_changed.connect(_on_heat_changed)


#func _physics_process(delta: float) -> void:
	##if GameManager._current_state == GameManager.GameState.GAME_OVER:
	#if not shader_paused:
		#texture_rect.material.set_shader_parameter(&"speed", 0.0)
		#shader_paused = true
	##return
	#
	## Increase speed every 2 seconds
	#if !max_speed_reached:
		#elapsed_time += delta
		#
		#if elapsed_time >= 2.0:
			#if speed < 30:
				#speed += 5.0
			#else:
				#max_speed_reached = true
			#
			#elapsed_time = 0.0
#
	##position.y -= speed * delta

func _initialize_heat_distortion() -> void:
	gradient_texture = texture as GradientTexture2D
	_point_1_color = gradient_texture.gradient.get_color(0)
	_point_2_color = gradient_texture.gradient.get_color(1)
	gradient_texture.gradient.set_color(0, Color(_point_1_color.r, _point_1_color.g, _point_1_color.b, 0))
	gradient_texture.gradient.set_color(1, Color(_point_2_color.r, _point_2_color.g, _point_2_color.b, 0))

func _on_heat_changed(value: float) -> void:
	#var heat_rating : float = lerpf(0, 0.55, value / 100)
	gradient_texture.gradient.set_color(0, Color(_point_1_color.r, _point_1_color.g, _point_1_color.b, lerpf(0, 0.35, value / 100)))
	gradient_texture.gradient.set_color(1, Color(_point_2_color.r, _point_2_color.g, _point_2_color.b, lerpf(0, 0.55, value / 100)))
