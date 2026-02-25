extends CharacterBody2D
class_name Enemy

var enemy_type: String = ""

var speed: float
var max_health: int
var current_health: int
var is_special_animating: = false 
var reward:int
var is_dead: = false

func _ready() -> void:
	setup_enemy()

func setup_enemy() -> void:
	if GameData.ENEMY_DATA.has(enemy_type):
		var data = GameData.ENEMY_DATA[enemy_type]
		max_health = data["max_health"]
		current_health = max_health
		speed = data["speed"]
		reward = data["gold_value"]
	else:
		push_error("Enemy type '" + enemy_type + "' not found in GameData")

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		die()

func _process(delta: float) -> void:
	if !is_special_animating:
		move(delta)
		special(delta)

func move(delta:float):
	var parent = get_parent()
	if parent is PathFollow2D:
		parent.progress += speed * delta
		var direction = Util.get_foward_vector(parent.get_parent(),parent)
		if parent.progress_ratio >= 1.0:
			reached_end()
		turn(direction,'Walk',direction.x > 0)

func turn(direction,activity,is_flip=false,is_await:bool=false) -> void:
	if direction == Vector2.ZERO: return
	var adjusted_direction = Vector2(direction.round().x,0) if abs(direction.round().x) == 1 else direction.round()

	$AnimatedSprite2D.animation = Util.anim_map[adjusted_direction] + "_" + activity
	$AnimatedSprite2D.flip_h = is_flip
	$AnimatedSprite2D.play()
	if is_await:
		is_special_animating = true
		await $AnimatedSprite2D.animation_finished

func special(delta):
	pass

func reached_end():
	queue_free()

func die():
	if is_dead:
		return
	is_dead = true
	var parent = get_parent()
	var direction = Util.get_foward_vector(parent.get_parent(),parent)
	await turn(direction,'Death',direction.x > 0,true)
	GameData.player_money += reward
	queue_free()
