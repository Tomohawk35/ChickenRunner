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
	proj_inst.set_velocity(speed, dir)
	player.add_child(proj_inst) # TODO: Make a child of the level node or root node. 
	return true
