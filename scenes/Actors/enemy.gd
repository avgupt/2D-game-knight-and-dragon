extends "res://Actors/actor.gd"

func _ready() -> void:
	velocity.x = -speed.x 

func _physics_process(delta: float) -> void:
	if is_on_wall():
		velocity.x *= -1.0
		
	velocity = move_and_slide(velocity, Vector2.UP)		
