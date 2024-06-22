extends Node

const WAV_FILES_COUNT: int = 17
const DO_SPIT_THRESHOLD: float = 0.5

const SPITS_BUS: String = "Spits"
var spits_bux_idx: int

var stream_player: AudioStreamPlayer
var wav_loader: AudioLoader
var wav_streams: Array[AudioStreamWAV]

# signals
var do_spit: bool
signal spitting(is_spitting: bool)

func _setup_stream_player():
	wav_loader = AudioLoader.new()
	for i in WAV_FILES_COUNT:
		var wav = wav_loader.loadfile("res://Scenes/Audio/spit_samples/Spit-%s.wav" % str(i+1))
		var wav_size = wav.data.size()
		wav.loop_begin = wav_size * 0.25
		wav.loop_end = wav_size * 0.75
		wav_streams.append(wav)
	
	stream_player = AudioStreamPlayer.new()
	stream_player.bus = SPITS_BUS
	stream_player.stream = wav_streams[0] # pre-load a sample
	
	get_parent().add_child(stream_player)
	stream_player.finished.connect(_on_stream_player_finished)

func _ready():
	call_deferred("_setup_stream_player")
	
func _process(_delta):
	spitting.emit(stream_player.playing)
	if do_spit and not stream_player.playing:
		var wav = wav_streams[randi_range(0, WAV_FILES_COUNT -1)]
		wav.loop_mode = AudioStreamWAV.LOOP_DISABLED
		stream_player.stream = wav
		stream_player.play()

func _on_stream_player_finished():
	if not do_spit:
		stream_player.stop()

func _on_mic_handler_blow_power(power):
	if do_spit != (power >= DO_SPIT_THRESHOLD):
		var wav_size = stream_player.stream.data.size()
		stream_player.stream.loop_mode = \
			AudioStreamWAV.LOOP_FORWARD if do_spit \
			else AudioStreamWAV.LOOP_DISABLED
		
		do_spit = not do_spit
