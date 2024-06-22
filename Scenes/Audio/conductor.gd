class_name Conductor
extends Node

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
	var time_seconds = $Player.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	# Validation
	if not _is_valid_update(time_seconds):
		return
	var beat = time_seconds / 60 * bpm
	var prev_beat = _prev_time_seconds / 60 * bpm
	if floor(beat) > floor(prev_beat):
		# Beat happened this frame!
		quarter_passed.emit(floor(beat))
	# Keep track of the previous frame's time
	_prev_time_seconds = time_seconds
