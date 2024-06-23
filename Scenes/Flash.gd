extends CanvasModulate

@export var flash_color : Color
const FLASH_TIME = 0.1

func randomize_color():
	flash_color = Color(randf(),randf(),randf())

func _on_flash(beat):
	if color != Color(1,1,1):
		return
	randomize_color()
	var tween = create_tween()
	tween.tween_property(self, "color", flash_color, FLASH_TIME)
	tween.chain().tween_property(self, "color", Color(1,1,1,), FLASH_TIME)
