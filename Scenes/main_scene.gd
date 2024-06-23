extends Node2D

@export var cake : Cake
@export var camera : Camera2D
@export var face : Face
@export var crew : Sprite2D
@export var conductor : Conductor
@export var canvas_modulate : CanvasModulate
@export var gameover_scene: PackedScene
@export var congrats_scene: PackedScene

const NEW_CANDLE_DELAY = 4
var new_candle_timer = 0
@onready var seconds_per_beat = 60.0 / conductor.bpm

var beats_to_move = 2

func _ready():
	conductor.bpm = DifficultyManager.bpm
	cake.num_candles = DifficultyManager.age
	face.move_to(cake.get_random_candle_x(), beats_to_move * seconds_per_beat)

func _process(delta):
	if new_candle_timer >= NEW_CANDLE_DELAY:
		new_candle_timer = 0
		face.move_to(cake.get_random_candle_x(), beats_to_move * seconds_per_beat)


func _on_face_is_spitting(_spitting):
	if _spitting:
		crew.frame = 1


func _on_conductor_quarter_will_pass(beat):
	new_candle_timer += 1

func goto_gameover():
	get_tree().change_scene_to_packed(gameover_scene)

func goto_level_complete():
	get_tree().change_scene_to_packed(congrats_scene)

func _on_gameover():
	DifficultyManager.gameover()
	var tween = get_tree().create_tween()
	tween.connect("finished", goto_gameover)
	tween.tween_property(canvas_modulate, "color", Color(0,0,0), 1.0)


func _on_all_candles_out():
	DifficultyManager.level_complete()
	var tween = get_tree().create_tween()
	tween.connect("finished", goto_level_complete)
	tween.tween_property(canvas_modulate, "color", Color(0,0,0), 1.0)
