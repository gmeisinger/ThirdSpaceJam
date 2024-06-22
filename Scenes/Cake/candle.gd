class_name Candle
extends Node2D

@export var flame : CPUParticles2D

@onready var starting_flame_amount = flame.amount
@onready var tween = create_tween()


var lit = true
# flame will be reduced by 1 particle at this rate
var _fade_time = 1.0
var _regen_time = 0.5

func _ready():
	tween.connect("finished", _on_tween_finished)
	tween.tween_property(flame, "amount", 0, _fade_time)

func _on_tween_finished():
	if flame.amount == 0:
		lit = false
		flame.emitting = false

func _on_blow_detector_area_entered(area):
	print("getting blown!")
	tween.stop()
	tween.tween_property(flame, "amount", 0, _fade_time)

func _on_blow_detector_area_exited(area):
	print("not getting blown!")
	tween.stop()
	if lit:
		tween.tween_property(flame, "amount", starting_flame_amount, _regen_time)

