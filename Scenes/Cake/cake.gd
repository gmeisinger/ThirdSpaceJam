class_name Cake
extends Node2D

signal all_candles_out()

@export var num_candles : int = 8
@export var candle_parent : Node2D

@onready var sprite : Sprite2D = get_node("Sprite")
@onready var cake_width : int = sprite.texture.get_width()

var candle_scene = preload("res://Scenes/Cake/candle.tscn")

var lit = []
var unlit = []

const RELIGHT_MIN = 20
const RELIGHT_MAX = 35
var relight_time = RELIGHT_MAX
var relight_timer = 0

func _ready():
	relight_time = randi_range(RELIGHT_MIN, RELIGHT_MAX)
	var candle_offset = candle_parent.position.x
	var usable_width = cake_width - (candle_offset * 2)
	for i in range(num_candles):
		var posx = i * (usable_width / (num_candles - 1))
		var candle = candle_scene.instantiate()
		candle.position.x = posx
		candle_parent.add_child(candle)
		lit.append(candle)
		candle.connect("went_out", _on_candle_went_out)
		candle.connect("relit", _on_candle_relit)

func _on_candle_went_out(candle : Candle):
	lit.erase(candle)
	unlit.append(candle)
	if len(lit) == 0:
		all_candles_out.emit()

func _on_candle_relit(candle):
	unlit.erase(candle)
	lit.append(candle)

func get_random_candle_x():
	if len(lit) == 0:
		return 0
	var next : Candle = lit[randi_range(0, len(lit)-1)]
	var next_x = next.global_position.x
	return next_x

func _process(delta):
	#relight_timer += delta
	if relight_timer > relight_time:
		relight_timer = 0
		relight_time = randi_range(RELIGHT_MIN, RELIGHT_MAX)
		if len(unlit) == 0:
			return
		var relit_candle = unlit[randi_range(0, len(unlit)-1)]
		relit_candle.light()
		unlit.erase(relit_candle)
		lit.append(relit_candle)


func _on_conductor_quarter_will_pass(beat):
	relight_timer += 1
