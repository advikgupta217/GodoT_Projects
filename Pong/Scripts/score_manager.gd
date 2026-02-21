extends Node

var left_score := 0
var right_score := 0

func add_left_point():
	left_score += 1
	print("Left Player:", left_score)

func add_right_point():
	right_score += 1
	print("Right Player:", right_score)
