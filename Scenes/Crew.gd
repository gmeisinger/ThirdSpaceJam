extends Sprite2D

const EW_TIME = 1.0
var ew_timer = 0.0
var grossed_out = false
var _camera_effects_started: bool

func _process(delta):
	if grossed_out:
		ew_timer += delta
		if ew_timer > EW_TIME:
			frame = 0
			grossed_out = false

func _on_frame_changed():
	grossed_out = true if frame == 1 else false
	ew_timer = 0.0


func _on_conductor_quarter_will_pass(beat):
	if not _camera_effects_started:
		return
		
	var interval = 60 / DifficultyManager.bpm
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y + 30, interval / 2).set_trans(Tween.TRANS_SINE)
	tween.chain().tween_property(self, "position:y", position.y, interval / 2).set_trans(Tween.TRANS_SINE)


func _on_camera_camera_effects_started(_beat):
	_camera_effects_started = true
