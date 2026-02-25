extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var main_scene = get_tree().current_scene
	if main_scene.has_method("initiate_tower_placement"):
		main_scene.initiate_tower_placement('archer_tower')
	else:
		# Use that error throwing we talked about!
		push_error("Main scene is missing initiate_tower_placement function!")
