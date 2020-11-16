extends "res://entities/Actor.gd"

const PI_OVER_2 = PI / 2

export(float) var speed := 200.0
export(float) var friction := 0.01
export(float) var acceleration := 0.1

export(Vector2) var velocity := Vector2()

func get_input() -> Vector2:
	# stub implimentation
	return Vector2()

func _physics_process(_delta) -> void:
	var direction = get_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	
	var collision := move_and_collide(velocity * _delta)
	if collision:
		self._on_collision(collision)

func _on_collision(collision: KinematicCollision2D) -> void:
	self._handle_bounce(collision)

func _handle_bounce(collision: KinematicCollision2D) -> void:
	
	velocity = velocity.reflect(collision.normal.rotated(PI_OVER_2))
