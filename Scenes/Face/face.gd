class_name Face
extends Node2D

@export var blow_zone : Area2D
@export var spit_emitter : GPUParticles2D

@onready var start_x = position.x
@onready var tween = create_tween()

signal is_spitting(_spitting : bool)
signal breath_left(_breath : float)

var blow_threshold = .1

var spitting = false
var blowing = true

var breath_amount : float = 100
const MIN_BREATH = 10.0
const BREATH_MAX = 100.0
const BREATH_LOSS_RATE = 50
const BREATH_GAIN_RATE = 25

func move_to(new_x : int, time : float):
	tween.tween_property(self, "position:x", new_x, time)

func blow(_blow : bool):
	if blowing != _blow:
		blowing = _blow
		blow_zone.monitorable = blowing

func spit(_spit : bool):
	spit_emitter.emitting = _spit
	if spitting != _spit:
		spitting = _spit
		is_spitting.emit(spitting)

func _on_mic_handler_blow_power(power):
	print(power)
	if power > blow_threshold and breath_amount > MIN_BREATH:
		blow(true)
		if power == 1:
			spit(true)
		else:
			spit(false)
	elif power < blow_threshold:
		blow(false)
		spit(false)

func _process(delta):
	if blowing:
		breath_amount -= delta * BREATH_LOSS_RATE
		if breath_amount <= 0:
			blow(false)
			spit(false)
	else:
		breath_amount += delta * BREATH_GAIN_RATE
		if breath_amount > BREATH_MAX:
			breath_amount = BREATH_MAX
	breath_left.emit(breath_amount)
