class_name OptionsMenu
extends Control

@export var input_devices : OptionButton
@onready var devices = AudioServer.get_input_device_list()

func _ready():
	for device in devices:
		input_devices.add_item(device)

func _on_input_devices_item_selected(index):
	AudioServer.set_input_device(input_devices.get_item_text(index))

func _process(delta):
	if Input.is_action_just_pressed("Cancel"):
		visible = false


func _on_close_pressed():
	visible = false
