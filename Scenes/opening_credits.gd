extends CanvasLayer

@export var canvas_modulate : CanvasModulate

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(canvas_modulate, "color", Color(1,1,1), 2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
