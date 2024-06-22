extends Sprite2D

const EW_TIME = 1.0
var ew_timer = 0.0
var grossed_out = false

func _process(delta):
	if grossed_out:
		ew_timer += delta
		if ew_timer > EW_TIME:
			frame = 0
			grossed_out = false

func _on_frame_changed():
	grossed_out = true if frame == 1 else false
	ew_timer = 0.0
