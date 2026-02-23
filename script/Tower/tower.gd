extends Node2D
class_name tower
signal clicked_on_tower(type,level,global_pos,instance)
# Called when the node enters the scene tree for the first time.

var type
var damage:int
var cool_down:float
var max_health:int
var level:int = 1
var just_upgraded:bool = false

func open_upgrade_menu():
	var level
	var global_pos = global_position
	
	clicked_on_tower.emit(type,level,global_pos,self)
	
func _ready() -> void:
	if GameData.TOWER_DATA.has(type):
		assign_stat(type)
	else:
		push_error('There are no tower type ' + type)

func assign_stat(type):
	if GameData.TOWER_DATA[type].has(level):
		print(level)
		damage = GameData.TOWER_DATA[type][level]['damage']
		cool_down = GameData.TOWER_DATA[type][level]['cool_down']
		max_health = GameData.TOWER_DATA[type][level]['max_health']
	else:
		push_error('There are no level ' + str(level))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
