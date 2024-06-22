extends Node2D

@export var cake : Cake
@export var camera : Camera2D
@export var face : Face

func _ready():
	face.position.x = cake.candle_parent.position.x
	face.move_to(cake.get_next_candle_x(), 3.0)
