extends "res://entities/Actor.gd"

export(float) var speed := 200.0
export(float) var friction := 0.01
export(float) var acceleration := 0.1

export(Vector2) var velocity := Vector2()

func get_input() -> Vector2:
	# stub implimentation
	return Vector2.ZERO

func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)
