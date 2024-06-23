extends "res://Scenes/StateMachine/base_state.gd"


func enter():
	host.anim.stop()
	host.sprite.frame = 2
	host.eye.frame = 3
	host.hand.frame = 1
	host.anim.play("tired")
	
func update(_delta):
	pass # do stuff with eye
