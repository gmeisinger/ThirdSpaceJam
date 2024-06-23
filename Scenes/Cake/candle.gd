class_name Candle
extends Node2D

signal went_out(candle : Candle)
signal relit(candle : Candle)

const SCORE_BONUS : int = 200

@onready var flame : CPUParticles2D = get_node("Flame")

@onready var starting_flame_scale = flame.scale_amount_min

var tween : Tween

var lit = true
# flame will be reduced by 1 particle at this rate
var _fade_time = .5
var _regen_time = .5

var in_grace_period = false
var grace_period_timer = 0.0
const GRACE_PERIOD = 0.02

func light():
	lit = true
	flame.scale_amount_min = starting_flame_scale
	flame.scale = Vector2.ONE
	flame.emitting = true

func _on_tween_finished():
	if flame.scale_amount_min == 0:
		#print("candle blown out!")
		lit = false
		flame.emitting = false
		went_out.emit(self)
		DifficultyManager.add_score(SCORE_BONUS)

func _on_blow_detector_area_entered(area):
	#print("getting blown!")
	if in_grace_period:
		in_grace_period = false
	if tween:
		tween.kill()
	tween = create_tween()
	tween.connect("finished", _on_tween_finished)
	tween.tween_property(flame, "scale_amount_max", 0, _fade_time)
	tween.parallel().tween_property(flame, "scale", Vector2.ZERO, _fade_time)

func _on_blow_detector_area_exited(area):
	in_grace_period = true

func _process(delta):
	if in_grace_period:
		grace_period_timer += delta
		if grace_period_timer > GRACE_PERIOD:
			grace_period_timer = 0.0
			in_grace_period = false
			#print("not getting blown!")
			if tween:
				tween.kill()
			if lit:
				tween = create_tween()
				tween.connect("finished", _on_tween_finished)
				tween.tween_property(flame, "scale_amount_min", starting_flame_scale, _regen_time)
				tween.parallel().tween_property(flame, "scale", Vector2.ONE, _fade_time)
