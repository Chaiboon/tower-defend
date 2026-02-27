extends Node

var ghost_tower:Node2D = null
var is_placing:bool = false
var current_tower_id: String = ""

func _ready() -> void:
	$SpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_placing and ghost_tower:
		ghost_tower.global_position = get_viewport().get_mouse_position()
		var tile_map = get_node('TileMap')
		var mouse_pixel_pos = tile_map.get_local_mouse_position()
		var map_pos = tile_map.local_to_map(mouse_pixel_pos)
		var sprite_size = ghost_tower.get_node('BaseAnimation2D').sprite_frames.get_frame_texture('Idle_LV1',0).get_size()
		
		#offset by tower area
		var positive_offset = Vector2i(0,2)

		if can_place_here(map_pos+positive_offset):
			ghost_tower.modulate = Color(1,1,1,0.5)
		else:
			ghost_tower.modulate = Color(1.0, 0.0, 0.0, 0.5)
		#update_ghost_visuals()

func _unhandled_input(event):
	if not is_placing:
		return
		
	if event.is_action_pressed("ui_cancel") or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT):
		cancel_placement()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var tile_map = get_node('TileMap')
		var mouse_pixel_pos = tile_map.get_local_mouse_position()
		var map_pos = tile_map.local_to_map(mouse_pixel_pos)
		var positive_offset = Vector2i(0,2)

		if can_place_here(map_pos+positive_offset):
			finalize_placement()
		else:
			var warning_label = get_node('HUD/CenterLabel')
			warning_label.text = 'Can not place here'
			warning_label.modulate.a = 1.0
			warning_label.visible = true
			
			var tween: = warning_label.create_tween()
			tween.tween_property(warning_label,'modulate:a',0.0,1.5)
			tween.finished.connect(func(): warning_label.visible = false)
			
func can_place_here(position_on_map) -> bool:
	var tile_map = get_node('TileMap')
	var data = tile_map.get_cell_tile_data(0, position_on_map)
	if data:
		return data.get_custom_data("tile_type") == 'Grass'
	return false

func finalize_placement():
	ghost_tower.modulate = Color(1,1,1,1)
	ghost_tower.get_node("Area2D").monitoring = true
	ghost_tower.get_node("StateMachine").set_process(true)
	if ghost_tower.has_method("play_build_animation"):
		ghost_tower.play_build_animation()
	GameData.player_money = GameData.player_money - GameData.TOWER_DATA['archer_tower']['purchasing_price']
	ghost_tower = null
	is_placing = false
	current_tower_id = ""

func cancel_placement():
	if ghost_tower != null:
		ghost_tower.queue_free()
		ghost_tower = null
		
	is_placing = false
	current_tower_id = ""

func initiate_tower_placement(tower_type:String) -> void:
	current_tower_id = tower_type
	
	var tower_resource = load("res://scenes/tower/" + tower_type + ".tscn")
	ghost_tower = tower_resource.instantiate()
	ghost_tower.modulate = Color(1,1,1,0.5)
	ghost_tower.get_node("StateMachine").set_process(false)
	
	ghost_tower.get_node("Area2D").monitoring = false
	add_child(ghost_tower)
	is_placing = true

func spawn_enemy():
	var path_to_follow = $MobPath
	
	var path_follow = PathFollow2D.new()
	path_follow.loop = false
	path_follow.rotates = false
	
	var enemy = preload('res://scenes/enemy/orc.tscn')
	var slime = enemy.instantiate()
	
	path_to_follow.add_child(path_follow)
	path_follow.add_child(slime)	

func _on_spawn_timer_timeout() -> void:	
	spawn_enemy()
