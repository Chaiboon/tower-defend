extends Enemy
class_name Slime

@export var trigger_special_threshold:int = 60 

func _init() -> void:
	enemy_type = "Slime"

func special(delta):
	if current_health <= max_health * trigger_special_threshold / 40:
		var parent_follower = get_parent()
		if not parent_follower is PathFollow2D: return
	
		var current_progress = parent_follower.progress
		var direction = Util.get_foward_vector(parent_follower.get_parent(),parent_follower)
		var animation_preffix = __get_direction_prefix(direction)

		$AnimatedSprite2D.animation = animation_preffix + "_Special"
		$AnimatedSprite2D.play()
		is_special_animating = true
		
		await $AnimatedSprite2D.animation_finished

		__spawn_duplicate_slime(current_progress,animation_preffix)
		parent_follower.queue_free()
		
func __get_direction_prefix(dir: Vector2) -> String:
	var snapped = dir.normalized().round()
	return Util.anim_map[snapped]

func __spawn_duplicate_slime(current_progress,animation_prefix):
	var path_node = get_parent().get_parent()
	for i in range(2):
		var new_follower = PathFollow2D.new()
		new_follower.loop = false
		new_follower.rotates = false
		path_node.add_child(new_follower)
		
		new_follower.progress = current_progress + 5+(i*randf()*30)
		
		var duplicate_slime_scene = preload('res://scenes/enemy/slime.tscn')
		var duplicated_slime = duplicate_slime_scene.instantiate()
		new_follower.add_child(duplicated_slime)
		
		if duplicated_slime.has_node('AnimatedSprite2D'):
			duplicated_slime.get_node('AnimatedSprite2D').play(animation_prefix + '_Walk')
