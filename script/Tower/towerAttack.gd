extends State
class_name TowerAttack

func enter(enemy):
	target_enemy = enemy
	if is_instance_valid(target_enemy):
		var arrow_scene = preload("res://scenes/bullets/Projectile.tscn")
		var marker = $"../../HeadAnimation2D/Marker2D"
		var arrow = arrow_scene.instantiate()
		arrow.global_position = marker.global_position
		arrow.target = target_enemy
		arrow.damage = get_parent().get_parent().damage
		get_tree().current_scene.add_child(arrow)

func exit():
	pass
	
func update(_delta: float):
	if is_instance_valid(target_enemy):
		Transitioned.emit(self,"towerpreattack",target_enemy)
	else:
		Transitioned.emit(self,"toweridle")
	
func physics_update(_delta: float):
	pass
