extends "res://Scenes/StateMachine/base_state.gd"


func enter():
	host.anim.stop()
	host.sprite.frame = 0
	host.eye.frame = 0
	host.hand.frame = 1
