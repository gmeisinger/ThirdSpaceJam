extends Camera2D

@export var eye: Sprite2D

var _position: Vector2
var _zoom: Vector2

var interval: float

const EFFECTS_TOGGLE_PERIOD__BARS: int = 8 * 4
const BARS_NEEDED_BEFORE_EFFECTS: int = 8 * 4 
const BEATS_TO_ZOOM: int = 4
var beat_count: int
var effects_active: bool

signal camera_effects_started()

func _ready():
	# Cache starting parameters
	_position = self.position
	_zoom = self.zoom
	
	interval = 60 / DifficultyManager.bpm

func _on_conductor_quarter_will_pass(beat):
	if beat >= BARS_NEEDED_BEFORE_EFFECTS:
		camera_effects_started.emit()
		
		if not int(beat_count)%EFFECTS_TOGGLE_PERIOD__BARS:
			effects_active = not effects_active
			
		if (effects_active):
			if int(beat_count)%BEATS_TO_ZOOM and (randi_range(0, 1) if int(beat_count)%4 else true):
				# Tween Zoom
				var tween = create_tween()
				var zoom_amt = randf_range(1.2, 1.3) if not int(beat_count)%16 else randf_range(1.0, 1.1)
				tween.tween_property(self, "zoom", Vector2(zoom_amt, zoom_amt), interval / 3)
				#tween.set_trans(Tween.TRANS_ELASTIC)
				tween.set_ease(Tween.EASE_IN_OUT)
				tween.chain().tween_property(self, "zoom", _zoom, interval / 3)

				# Tween Position
				var pos_tween = create_tween()
				var destination = (eye.global_position - position).normalized() * randi_range(50, 150)
				destination.y = destination.y / 2
				pos_tween.tween_property(self, "position", position + destination, interval / 3)
				tween.set_trans(Tween.TRANS_ELASTIC)
				tween.set_ease(Tween.EASE_IN_OUT)
				pos_tween.tween_property(self, "position", _position, interval / 2)
				
		beat_count += 1
