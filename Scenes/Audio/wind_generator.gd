extends Node

var playback: AudioStreamGeneratorPlayback
var stream_player: AudioStreamPlayer
var generator: AudioStreamGenerator

const WIND_NOISE_BUS: String = "Wind Noise"
const LOW_PASS_FILTER_IDX: int = 0
const AMPLIFY_EFFECT_IDX: int = 1
var wind_noise_bus_idx: int
var low_pass_filter: AudioEffectLowPassFilter
var amplify_effect: AudioEffectAmplify

var sample_scale: float

func _on_mic_handler_blow_power(power):
	sample_scale = power

func _setup_stream_player():
	wind_noise_bus_idx = AudioServer.get_bus_index(WIND_NOISE_BUS)
	low_pass_filter = AudioServer.get_bus_effect(wind_noise_bus_idx, LOW_PASS_FILTER_IDX)
	amplify_effect = AudioServer.get_bus_effect(wind_noise_bus_idx, AMPLIFY_EFFECT_IDX)
	
	generator = AudioStreamGenerator.new()
	stream_player = AudioStreamPlayer.new()
	stream_player.stream = generator
	stream_player.bus = WIND_NOISE_BUS
	get_parent().add_child(stream_player)
	stream_player.play()
	playback = stream_player.get_stream_playback()

func _ready():
	call_deferred("_setup_stream_player")

func _process(_delta):
	var volume_db = linear_to_db(sample_scale)
	#low_pass_filter.cutoff_hz = 2500 * sample_scale
	amplify_effect.volume_db = volume_db
	
	# Load new samples into audio generator
	for i in range(playback.get_frames_available()):
		var sample = randf()
		playback.push_frame(Vector2(sample, sample))
