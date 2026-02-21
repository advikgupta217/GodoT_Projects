extends StaticBody2D

@export var speed := 400.0

func _physics_process(delta):
	var direction := Input.get_axis("w", "s")
	
	position.y += direction * speed * delta
