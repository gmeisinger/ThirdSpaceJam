class_name Candle
extends Node2D

@onready var flame : CPUParticles2D = get_node("Flame")

@onready var starting_flame_amount = flame.amount

var tween

var lit = true
# flame will be reduced by 1 particle at this rate
var _fade_time = 1
var _regen_time = 0.5

func _ready():
	tween = get_tree().create_tween()
	tween.connect("finished", _on_tween_finished)

func _on_tween_finished():
	if flame.amount == 1:
		print("candle blown out!")
		lit = false
		flame.emitting = false

func _on_blow_detector_area_entered(area):
	print("getting blown!")
	tween.stop()
	tween = get_tree().create_tween()
	tween.connect("finished", _on_tween_finished)
	tween.tween_property(flame, "amount", 1, _fade_time)
	tween.tween_property(flame, "emitting", false, 0)

func _on_blow_detector_area_exited(area):
	print("not getting blown!")
	tween.stop()
	if lit:
		tween = get_tree().create_tween()
		tween.connect("finished", _on_tween_finished)
		tween.tween_property(flame, "amount", starting_flame_amount, _regen_time)

