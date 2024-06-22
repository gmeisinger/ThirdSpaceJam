extends Node2D

@export var cake : Cake
@export var camera : Camera2D
@export var face : Face

const NEW_CANDLE_DELAY = 3
var new_candle_timer = 0

func _ready():
	face.move_to(cake.get_random_candle_x(), 1.5)

func _process(delta):
	new_candle_timer += delta
	if new_candle_timer >= NEW_CANDLE_DELAY:
		new_candle_timer = 0
		face.move_to(cake.get_random_candle_x(), 1.5)
