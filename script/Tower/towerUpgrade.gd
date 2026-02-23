extends State
class_name TowerUpgrade

var tower
var upgrade_to
var base
var archer

func enter(enemy):
	target_enemy = null
	tower = get_parent().get_parent()
	upgrade_to = tower.level + 1
	base = tower.get_node('BaseAnimation2D')
	archer = tower.get_node('HeadAnimation2D')
	
	archer.visible = false
	
func exit():
	pass
	
func update(_delta: float):
	if tower.level < upgrade_to:
		tower.level = upgrade_to
		tower.assign_stat(tower.type)
	
func physics_update(_delta: float):
	if !archer.visible:
		base.animation = "Upgrade_" + str(upgrade_to)
		base.play()
		await base.animation_finished
		base.animation = "Idle_LV" + str(upgrade_to)
		base.play()
		archer.visible = true
		tower.just_upgraded = true
		Transitioned.emit(self,"toweridle",null)
