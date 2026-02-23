extends State
class_name TowerPreAttack

func enter(enemy):
	target_enemy = enemy
	var timer = $"../../Timer"
	timer.wait_time = get_parent().get_parent().cool_down
	if not timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
func exit():
	var timer = $"../../Timer"
	timer.stop()
	if timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.disconnect(_on_timer_timeout)
	
func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	if is_instance_valid(target_enemy):
		var direction = target_enemy.global_position - get_parent().get_parent().global_position
		direction = direction.normalized().round()
		var adjusted_direction = Vector2(direction.x,0) if abs(direction.x) == 1 else direction
		var archer_direction = $"../../HeadAnimation2D"
		archer_direction.animation = Util.anim_map[adjusted_direction] + "_Preattack" 
		var is_flip = adjusted_direction.x > 0.0
		archer_direction.flip_h = is_flip
		archer_direction.play()

func _on_timer_timeout() -> void:
	var area = $"../../Area2D"
	if target_enemy == null:
		Transitioned.emit(self,"toweridle",null)
	elif area.overlaps_body(target_enemy):
		Transitioned.emit(self,"towerattack",target_enemy)
	else:
		Transitioned.emit(self,"toweridle",null)
