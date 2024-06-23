extends Camera2D

@export var eye: Sprite2D

var _position: Vector2
var _zoom: Vector2

var interval: float

const BARS_NEEDED_BEFORE_EFFECTS: int = 4 * 4
const BEATS_TO_ZOOM: int = 4
var beat_count: int

func _ready():
	# Cache starting parameters
	_position = self.position
	_zoom = self.zoom
	
	interval = 60 / DifficultyManager.bpm

func _on_conductor_quarter_will_pass(beat):
	if beat > BARS_NEEDED_BEFORE_EFFECTS:
		if not int(beat)%BEATS_TO_ZOOM:
			beat_count += 1
			beat_count = 0
			
			# Tween Zoom
			var tween = create_tween()
			var zoom_amt = randf_range(1.25, 1.675)
			tween.tween_property(self, "zoom", Vector2(zoom_amt, zoom_amt), interval / 3)
			#tween.set_trans(Tween.TRANS_ELASTIC)
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.chain().tween_property(self, "zoom", _zoom, interval / 3)

			# Tween Position
			var pos_tween = create_tween()
			pos_tween.tween_property(self, "position", Vector2(eye.global_position.x, eye.global_position.y / 2), interval / 3)
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.set_ease(Tween.EASE_IN_OUT)
			pos_tween.tween_property(self, "position", _position, interval / 2)
