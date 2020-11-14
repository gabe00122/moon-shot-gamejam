extends "res://entities/Planetoid.gd"

func _init():
	self.apply_impulse(Vector2(0, 0), Vector2(10, 0))
