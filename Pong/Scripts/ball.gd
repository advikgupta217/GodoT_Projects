extends CharacterBody2D

var speed := 400.0
const SPEED_INCREASE := 30.0
const MAX_SPEED := 900.0
var start_position: Vector2
@onready var hit_sound = $HitSound

func _ready():
	start_position = global_position
	launch()

func launch():
	speed = 400.0
	velocity = Vector2(
		[-1, 1].pick_random(),
		randf_range(-0.4, 0.4)
	).normalized() * speed


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

	if collision:
		var collider = collision.get_collider()

		if collider.name == "player" or collider.name == "player2":

			# increase speed
			hit_sound.play()
			speed = min(speed + SPEED_INCREASE, MAX_SPEED)

			# calculate hit offset
			var hit_offset = global_position.y - collider.global_position.y
			var half_height = collider.get_node("CollisionShape2D").shape.size.y / 2
			var normalized_offset = clamp(hit_offset / half_height, -1, 1)

			var max_angle = deg_to_rad(60)
			var angle = normalized_offset * max_angle

			var dir_x = -sign(velocity.x)
			velocity = Vector2(dir_x, sin(angle)).normalized() * speed

		else:
			velocity = velocity.bounce(collision.get_normal())
			
				
			
