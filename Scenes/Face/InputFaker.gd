extends Node

signal fake_breath_power(pow : float)

func _process(delta):
	if Input.is_action_pressed("breathe"):
		fake_breath_power.emit(1.0)
	else:
		fake_breath_power.emit(0)
