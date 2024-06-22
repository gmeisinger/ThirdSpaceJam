class_name Face
extends Node2D

@onready var start_x = position.x
@onready var tween = create_tween()

func move_to(new_x : int, time : float):
	tween.tween_property(self, "position:x", new_x, time)
