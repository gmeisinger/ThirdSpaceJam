extends "res://Scenes/StateMachine/base_state.gd"


func enter():
	host.anim.stop()
	host.sprite.frame = 1
	
func update(_delta):
	pass # do stuff with eye
