extends "res://entities/Planetoid.gd"

const Moon = preload("res://entities/moon/Moon.gd")

var _moon_set := {}
var _moons := []

func get_input() -> Vector2:
	var input := Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input


#func _on_moon_entered(moon: Moon):
#	_moons.append(mode)
