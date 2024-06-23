extends Node

var mic_stream: AudioStreamPlayer
var input_bus_idx: int

# signals
signal blow_power(power: float)

func _create_mic_stream():
	mic_stream = AudioStreamPlayer.new()
	mic_stream.bus = "Input"
	mic_stream.stream = AudioStreamMicrophone.new()
	get_parent().add_child(mic_stream)
	mic_stream.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	var devices = AudioServer.get_input_device_list()
	for device in devices:
		print(device)
	input_bus_idx = AudioServer.get_bus_index("Input")
	call_deferred("_create_mic_stream")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var peak_vol = AudioServer.get_bus_peak_volume_left_db(input_bus_idx, 0)
	var vol_normalized = db_to_linear(peak_vol)
	vol_normalized = ease(vol_normalized, -2)
	#print(vol_normalized)
	blow_power.emit(vol_normalized)
