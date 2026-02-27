extends CanvasLayer
var active_tower = null
var current_level:int

func _on_upgrade_button_button_down() -> void:
	var state_machine = active_tower.get_node('StateMachine')
	state_machine.on_child_transition(state_machine.current_state,'towerupgrade',null)
	GameData.player_money = GameData.player_money - get_node('Panel').get_node('VBoxContainer').get_node('UpgradeButton').upgrade_cost
	get_parent().is_opened = false
	self.queue_free()
	

func _on_sale_button_button_down() -> void:
	print('fuq sale')
	get_parent().is_opened = false
	self.queue_free()

func _on_cancel_button_button_down() -> void:
	get_parent().is_opened = false
	self.queue_free()
