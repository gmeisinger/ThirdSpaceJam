extends Control

signal gameover()

@export var meter : ProgressBar

var is_spitting = false
const SPIT_BUILD_RATE = 40.0

func _on_face_is_spitting(spitting : bool):
	is_spitting = spitting

func _process(delta):
	if is_spitting:
		meter.value += delta * SPIT_BUILD_RATE
	if meter.value >= meter.max_value:
		gameover.emit()
