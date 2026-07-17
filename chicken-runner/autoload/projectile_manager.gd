extends Node

enum ProjType { SWIPE }

const PROJECTILE_SCENES : Dictionary[ProjType, String] = {
	ProjType.SWIPE: "uid://6jvklk5gngfb",
}

func spawn_projectile(type: ProjType, speed: float, dir: Vector2) -> bool:
	var player : Chicken = get_tree().get_first_node_in_group("player")
	
	if !player:
		return false
	
	var proj_inst : Projectile = load(PROJECTILE_SCENES[type]).instantiate()
	proj_inst.global_position = player.global_position
	proj_inst.set_velocity(speed, dir)
	var proj_root : Node2D = get_tree().get_first_node_in_group("projectile_root")
	if proj_root:
		proj_root.add_child(proj_inst) 
		return true
	else:
		return false
