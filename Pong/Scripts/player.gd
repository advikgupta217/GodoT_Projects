extends StaticBody2D

@export var speed := 400.0

func _physics_process(delta):
	var direction := Input.get_axis("ui_up", "ui_down")
	
	position.y += direction * speed * delta
