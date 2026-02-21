extends CharacterBody2D

const SPEED := 400.0

func _physics_process(delta):
	var dir := Input.get_axis("w", "s")
	velocity.y = dir * SPEED
	move_and_slide()
