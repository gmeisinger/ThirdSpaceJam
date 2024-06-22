extends Control

@export var meter : ProgressBar

func _on_breath_changed(breath : float):
	meter.value = breath
