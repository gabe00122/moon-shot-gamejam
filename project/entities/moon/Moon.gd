extends "res://entities/Planetoid.gd"
const Planetoid = preload("res://entities/Planetoid.gd")

var orbit_target: Planetoid = null setget set_orbit_target
var orbit_target_offset := Vector2.ZERO
var orbit_target_velocity := Vector2.ZERO

func set_orbit_target(new_target: Planetoid):
	orbit_target = new_target
	orbit_target_offset = global_position - new_target.global_position
	orbit_target_velocity = (linear_velocity - new_target.linear_velocity) / 60
	custom_integrator = true
	can_sleep = false
	#call_deferred("_deferred_set_target", new_target)

func fire(direction: Vector2):
	orbit_target = null
	custom_integrator = false
	can_sleep = true
	apply_central_impulse(direction * 60)
	

#func _deferred_set_target(new_target):
#	if new_target != null:
#		orbit_target_offset = position - new_target.position
#		orbit_target_velocity = (linear_velocity - new_target.linear_velocity) / 60
#		mode = RigidBody2D.MODE_KINEMATIC
#	else:
#		last_position = global_position
#		mode = RigidBody2D.MODE_RIGID

func _integrate_forces(state: Physics2DDirectBodyState):
	if orbit_target != null && custom_integrator:
		orbit_target_velocity -= orbit_target_offset.normalized() * 10 / 60
		orbit_target_offset += orbit_target_velocity
		
		if orbit_target_offset.length() > 30:
			orbit_target_velocity *= 0.98
		#global_position = orbit_target.global_position + orbit_target_offset
		state.transform = Transform2D(0, orbit_target.global_position + orbit_target_offset)
		state.linear_velocity = Vector2.ZERO
		
		#z_index = -1 if inverse_z_index == (orbit_target_velocity.angle() > 0) else 1
