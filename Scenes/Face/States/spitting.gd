extends "res://Scenes/StateMachine/base_state.gd"


func enter():
	host.anim.stop()
	host.sprite.frame = 1
	host.eye.frame = 2
	
func update(_delta):
	pass # do stuff with eye
