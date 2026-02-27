extends Area2D
var count:int = 0
var is_builded:bool = false
var is_opened:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if !is_builded:
			is_builded = true
			return 
			
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !is_opened:
			is_opened = true
			open_upgrade_menu()

func open_upgrade_menu():
	var menu_scene = preload("res://scenes/upgrade_menu.tscn")
	var menu = menu_scene.instantiate()
	var offset_x:int
	var panel:Panel = menu.get_node('Panel')
	
	if get_viewport().get_visible_rect().size.x < self.global_position.x + panel.size.x + 15:
		offset_x = 15
	else:
		offset_x = -(15 + panel.size.x)
		
	panel.global_position = Vector2(self.global_position.x + 15,self.global_position.y)
	menu.active_tower = self.get_parent()
	menu.current_level = int(menu.active_tower.level)

	var upgrade_button:Button = menu.get_node('Panel').get_node('VBoxContainer').get_node('UpgradeButton')
	
	if !GameData.TOWER_DATA[menu.active_tower.type].has(menu.current_level+1):
		upgrade_button.visible = false
		add_child(menu)
		return
	
	if get_parent().upgrade_cost > GameData.player_money:
		upgrade_button.disabled = true
	
	var upgrade_cost = GameData.TOWER_DATA[menu.active_tower.type][menu.current_level]['upgrade_cost']
	
	upgrade_button.text = "Upgrade : " + str(upgrade_cost)
	upgrade_button.upgrade_cost = upgrade_cost
	add_child(menu)
