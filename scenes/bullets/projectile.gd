extends Area2D

@export var speed:int = 300
var target: Enemy = null
var damage:int 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_instance_valid(target):
		queue_free()
		return

	var direction = (target.global_position - global_position).normalized()
	global_position += direction * speed * delta
		
	update_sprite_direction(direction)

func update_sprite_direction(direction: Vector2):
	var is_flip_v:bool = false
	var is_flip_h:bool = false
	
	var angle_degree = direction.angle_to(Vector2.RIGHT) * 180/ PI
	if (angle_degree > 90 and angle_degree < 180) or (angle_degree > -270 and angle_degree < -180):
		is_flip_v = true
		angle_degree = abs(angle_degree - 180)
	elif (angle_degree > 180 and angle_degree < 270) or (angle_degree > -180 and angle_degree < -90):
		is_flip_h = true
		is_flip_v = true
		angle_degree = abs(angle_degree - 180)
	elif (angle_degree > 270 and angle_degree < 360) or (angle_degree > -90 and angle_degree < 0):
		is_flip_h = true
		angle_degree = abs(angle_degree)

	var frame_index = round(angle_degree / 7.5)
	
	$AnimatedSprite2D.frame = frame_index
	$AnimatedSprite2D.flip_v = is_flip_v
	$AnimatedSprite2D.flip_h = is_flip_h


func _on_body_entered(body: Node2D) -> void:
	body.take_damage(damage)
	queue_free()
