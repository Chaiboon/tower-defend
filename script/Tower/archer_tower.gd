extends tower

@onready var state_machine = get_node("StateMachine")

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	type = 'archer_tower'
