extends State
class_name TowerIdle

var tower

func enter(enemy):
	target_enemy = null
	tower = get_parent().get_parent()
	var area_detacter = $"../../Area2D"
	if not area_detacter.body_entered.is_connected(_on_enemy_entered):
		area_detacter.body_entered.connect(_on_enemy_entered)
	
func exit():
	var area_detacter = $"../../Area2D"
	if area_detacter.body_entered.is_connected(_on_enemy_entered):
		area_detacter.body_entered.disconnect(_on_enemy_entered)
	
func update(_delta: float):
	if tower.just_upgraded:
		update_targets_from_area()
	
func physics_update(_delta: float):
	var archer = get_parent().get_parent().get_node("HeadAnimation2D")
	archer.animation = "D_Idle"
	archer.play()

func _on_enemy_entered(body):
	update_targets_from_area()
	#if body.is_in_group("Enemy"):
		#target_enemy = get_tree().get_first_node_in_group('Enemy')
		#Transitioned.emit(self,"towerpreattack",target_enemy)
		
func update_targets_from_area():
	var bodies = tower.get_node('Area2D').get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group('Enemy'):
			tower.just_upgraded = false
			Transitioned.emit(self,"towerpreattack",body)
	
