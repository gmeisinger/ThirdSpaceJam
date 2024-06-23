class_name BaseState
extends Node

@export var is_starting_state : bool

var state_machine
var host

func init(_state_machine, _host):
	self.state_machine = _state_machine
	self.host = _host

func enter():
	pass

func exit():
	pass

func update(_delta):
	pass

func change_state(state_name):
	state_machine.change_state(state_name)
