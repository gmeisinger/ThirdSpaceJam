extends CanvasLayer

@export var options_menu : OptionsMenu
@export var canvas_modulate : CanvasModulate
@export var next_scene : PackedScene

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween()
	tween.tween_property(canvas_modulate, "color", Color(1,1,1), 1.0)

func _on_tween_finished():
	get_tree().change_scene_to_packed(next_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_just_pressed("OK"):
		#tween.stop()
		#tween = get_tree().create_tween()
		#tween.connect("finished", _on_tween_finished)
		#tween.tween_property(canvas_modulate, "color", Color(0,0,0), 1.0)


func _on_start_pressed():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.connect("finished", _on_tween_finished)
	tween.tween_property(canvas_modulate, "color", Color(0,0,0), 1.0)


func _on_options_pressed():
	options_menu.visible = true
