extends "res://Scenes/StateMachine/base_state.gd"


func enter():
	self.host.anim.stop()
	self.host.sprite.frame = 0
