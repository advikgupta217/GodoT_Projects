extends RigidBody2D

const speed := 400.0
var last_dir_x := 1   # remembers direction safely

func _ready():
	gravity_scale = 0
	linear_damp = 0
	angular_damp = 0
	launch()

func launch():
	last_dir_x = [-1, 1].pick_random()
	var dir_y = randf_range(-0.4, 0.4)
	linear_velocity = Vector2(last_dir_x, dir_y).normalized() * speed

func _on_body_entered(body):
	if body.name == "player" or body.name == "player2":
		linear_velocity.x = -linear_velocity.x
		global_position.x += sign(linear_velocity.x) * 5
		
func _physics_process(_delta):
	linear_velocity = linear_velocity.normalized() * speed
	
func _integrate_forces(state):
	for i in range(state.get_contact_count()):
		var paddle = state.get_contact_collider_object(i)
		if paddle and (paddle.name == "player" or paddle.name == "player2"):

			# Direction: left or right
			var dir_x = sign(linear_velocity.x) * -1

			# Distance from paddle center
			var hit_offset = global_position.y - paddle.global_position.y

			# Normalize (-1 to 1)
			var half_height = paddle.get_node("CollisionShape2D").shape.size.y / 2
			var normalized_offset = clamp(hit_offset / half_height, -1, 1)

			# Max bounce angle (in radians)
			var max_angle = deg_to_rad(60)

			# Final angle
			var angle = normalized_offset * max_angle

			# New velocity direction
			var direction = Vector2(dir_x, sin(angle)).normalized()
			linear_velocity = direction * speed
