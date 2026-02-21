extends Node2D

@export var lifetime := 0.25

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, lifetime)
	tween.tween_callback(queue_free)
