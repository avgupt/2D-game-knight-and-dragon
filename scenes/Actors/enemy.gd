extends "res://Actors/actor.gd"

func _ready() -> void:
	velocity.x = -speed.x
	$enemy.play("walk")
	get_node("enemy").set_flip_h(true)
	set_process(true)
	
func _process(delta):
	if (velocity.x >= 0.0):
		get_node("enemy").set_flip_h(false)
		
	if (velocity.x < 0.0):
		get_node("enemy").set_flip_h(true)

func _on_AttackDetector_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.global_position.y > get_node("AttackDetector").global_position.y or body.global_position.x < get_node("AttackDetector").global_position.y:
		return
	
	if Input.is_key_pressed(KEY_SHIFT):
		queue_free()

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_wall():
		velocity.x *= -1.0
		
	velocity.y = move_and_slide(velocity, Vector2.UP).y	


