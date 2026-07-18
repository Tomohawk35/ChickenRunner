extends ItemUseEffect
class_name ItemUseEffectFireProjectile

#enum ProjType { SWIPE, EGG }
enum Direction { UP, DOWN, LEFT, RIGHT }

#const PROJECTILE_SCENES : Dictionary[ProjType, String] = {
	#ProjType.SWIPE: "uid://6jvklk5gngfb",
	#ProjType.EGG: "uid://p7q2ilbrr6n3",
#}

const DIR_TRANSLATION : Dictionary[Direction, Vector2] = {
	Direction.UP : Vector2.UP,
	Direction.LEFT : Vector2.LEFT,
	Direction.RIGHT : Vector2.RIGHT,
	Direction.DOWN : Vector2.DOWN,
}

@export var projectile : ProjectileManager.ProjType = ProjectileManager.ProjType.SWIPE
@export var direction : Direction = Direction.UP
@export var speed : float = 50.0

func use() -> void:
	#var proj_inst : PackedScene = load(PROJECTILE_SCENES[projectile])
	match projectile:
		ProjectileManager.ProjType.SWIPE:
			if ProjectileManager.spawn_projectile(projectile, speed, DIR_TRANSLATION[direction]):
				pass
				# TODO: Put on cooldown or oneshot
		ProjectileManager.ProjType.EGG:
			if ProjectileManager.spawn_projectile(projectile, speed, DIR_TRANSLATION[direction]):
				pass
