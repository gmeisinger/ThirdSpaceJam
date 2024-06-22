extends CanvasLayer

@export var canvas_modulate : CanvasModulate
@export var next_scene : PackedScene

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_tree().create_tween()
	tween.tween_property(canvas_modulate, "color", Color(1,1,1), 1.0)

func _on_tween_finished():
	get_tree().change_scene_to_packed(next_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("OK"):
		tween.stop()
		tween = get_tree().create_tween()
		tween.connect("finished", _on_tween_finished)
		tween.tween_property(canvas_modulate, "color", Color(0,0,0), 1.0)
