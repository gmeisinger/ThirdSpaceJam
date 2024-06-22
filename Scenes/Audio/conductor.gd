class_name Conductor
extends Node

@export var curr_beat: float = 0
@export var curr_beat_without_latency: float = 0
@export var bpm: float = 80
@export var is_playing: bool = false

var master_time = 0.0
var _prev_time_seconds: float
# Other scripts can connect to this signal to know when the beat happens
# and what beat it was
signal quarter_passed(beat: int)
signal quarter_will_pass(beat: int)

func _is_valid_update(time_seconds: float) -> bool:
	return (
		# No weird web issue
		time_seconds < 1000 and
		# Time moved forward
		time_seconds > _prev_time_seconds)

func _process(delta: float) -> void:
	master_time += delta
	var time_seconds = master_time + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	# Validation
	if not _is_valid_update(time_seconds):
		return
	var beat = time_seconds / 60 * bpm
	var prev_beat = _prev_time_seconds / 60 * bpm
	if floor(beat) > floor(prev_beat):
		# Beat happened this frame!
		quarter_passed.emit(floor(beat))
	# Now adjust the time to be in the future
	var latency_in_beats = AudioServer.get_output_latency() / 60 * bpm
	beat += latency_in_beats
	prev_beat += latency_in_beats
	if floor(beat) > floor(prev_beat):
		# Beat will happen soon!
		quarter_will_pass.emit(floor(beat))
	# Keep track of the previous frame's time
	_prev_time_seconds = time_seconds
