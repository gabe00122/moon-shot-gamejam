extends "res://entities/Planetoid.gd"

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
