extends "res://Scenes/StateMachine/base_state.gd"


func enter():
	host.anim.stop()
	host.sprite.frame = 1
	host.eye.frame = 1
	host.hand.frame = 0
