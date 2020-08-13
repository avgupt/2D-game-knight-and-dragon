extends Actor

export var attack_impulse: = 1000.0

func _ready():
	$player.play("idle")
	set_process(true)
	
func _process(delta):
	
	if (Input.is_key_pressed(KEY_RIGHT)):
		$player.play("run")
	
	if Input.is_key_pressed(KEY_SPACE):
		$player.play("jump")
		
	if Input.is_key_pressed(KEY_SHIFT):
		$player.play("attack")
		#get_node("Player/player/attackMusic").play()
		
		
func _on_EnemyDetector_area_entered(area):
	velocity = calculate_attack_velocity(velocity, attack_impulse)

func _on_EnemyDetector_body_entered(body):
	queue_free()

func _physics_process(delta):
	var direction: = get_direction()
	
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	update_animation()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += GRAVITY * get_physics_process_delta_time()
	
	if (direction.y == -1.0):
		new_velocity.y = speed.y * direction.y

	return new_velocity
		
	
func update_animation():
	$player.play("idle")
		
func calculate_attack_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.y = -impulse
	return new_velocity


