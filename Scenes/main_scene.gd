extends Node2D

@export var cake : Cake
@export var camera : Camera2D
@export var face : Face
@export var crew : Sprite2D
@export var conductor : Conductor

const NEW_CANDLE_DELAY = 4
var new_candle_timer = 0
@onready var seconds_per_beat = 60.0 / conductor.bpm

var beats_to_move = 2

func _ready():
	face.move_to(cake.get_random_candle_x(), beats_to_move * seconds_per_beat)

func _process(delta):
	#new_candle_timer += delta
	if new_candle_timer >= NEW_CANDLE_DELAY:
		new_candle_timer = 0
		face.move_to(cake.get_random_candle_x(), beats_to_move * seconds_per_beat)


func _on_face_is_spitting(_spitting):
	if _spitting:
		crew.frame = 1


func _on_conductor_quarter_will_pass(beat):
	new_candle_timer += 1
	print(beat)
