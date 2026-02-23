extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
