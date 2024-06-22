class_name Cake
extends Node2D

@export var num_candles : int = 8
@export var candle_parent : Node2D

@onready var sprite : Sprite2D = get_node("Sprite")
@onready var cake_width : int = sprite.texture.get_width()

var candle_scene = preload("res://Scenes/Cake/candle.tscn")

func _ready():
	var candle_offset = candle_parent.position.x
	var usable_width = cake_width - (candle_offset * 2)
	for i in range(num_candles):
		var posx = i * (usable_width / (num_candles - 1))
		var candle = candle_scene.instantiate()
		candle.position.x = posx
		candle_parent.add_child(candle)

func get_next_candle_x():
	var next : Candle = candle_parent.get_child(randi_range(0, num_candles - 1))
	var next_x = next.global_position.x
	return next_x
