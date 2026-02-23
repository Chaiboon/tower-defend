extends Node

const anim_map = {Vector2.UP: "U",
					Vector2.DOWN: "D",
					Vector2.LEFT:"S",
					Vector2.RIGHT:"S"}

func get_foward_vector(path:Path2D,path_follow:PathFollow2D) -> Vector2:
	var curve = path.curve
	var progress = path_follow.progress
	var current_position = curve.sample_baked(progress)
	var next_position = curve.sample_baked(progress + 1.0)
	var direction = next_position - current_position
	return direction.normalized()
	
