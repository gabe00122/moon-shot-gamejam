extends "res://entities/Actor.gd"

export(float) var max_speed := -1
export(float) var acceleration := 0.1

export(String) var bounce_sound := ""
export(float) var bounce_sound_min_velocity := 0
export(float) var bounce_sound_min_volume := -60
export(float) var bounce_sound_max_volume := 0

var last_frame_linear_velocity := Vector2.ZERO

func get_input() -> Vector2:
	# stub implimentation
	return Vector2()

func _physics_process(delta) -> void:
	last_frame_linear_velocity = linear_velocity
	var direction = get_input()

	var amount_over := linear_velocity.length() - max_speed
	if amount_over > 0:
		_apply_movement_impules(linear_velocity.normalized() * -min(amount_over, acceleration * delta))

	if direction.length() > 0:
		_apply_movement_impules(direction.normalized() * acceleration * delta)

func _apply_movement_impules(vec: Vector2) -> void:
	apply_central_impulse(vec)

func _on_collision(collision: Node) -> void:
	_handle_bounce_sound(collision)

func _handle_bounce_sound(collision: Node) -> void:
	var impact_velocity: float

	if collision.get("last_frame_linear_velocity") != null:
		impact_velocity = last_frame_linear_velocity.distance_to(collision.last_frame_linear_velocity)
	else:
		impact_velocity = last_frame_linear_velocity.length()

	if bounce_sound != "" && bounce_sound_min_velocity <= impact_velocity:
		SoundEffectPlayerPool.play(
			bounce_sound,
			lerp(
				bounce_sound_min_volume,
				bounce_sound_max_volume,
				min((impact_velocity - bounce_sound_min_velocity) / max_speed, 1)
			)
		)
