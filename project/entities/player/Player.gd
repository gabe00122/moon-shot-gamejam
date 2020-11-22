extends "res://entities/Planetoid.gd"

const Moon = preload("res://entities/moon/Moon.gd")

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

func _physics_process(delta):
	if Input.is_action_just_pressed("fire_up"):
		_fire_moon(Vector2(0, -1))
	elif Input.is_action_just_pressed("fire_down"):
		_fire_moon(Vector2(0, 1))
	elif Input.is_action_just_pressed("fire_left"):
		_fire_moon(Vector2(-1, 0))
	elif Input.is_action_just_pressed("fire_right"):
		_fire_moon(Vector2(1, 0))

func _fire_moon(direction: Vector2):
	if !_moons.empty():
		var moon: Moon = _moons.pop_front()
		moon.fire(direction)

func _on_moon_entered(moon: Moon):
	if moon.orbit_target == null:
		moon.orbit_target = self
		_moons.append(moon)
