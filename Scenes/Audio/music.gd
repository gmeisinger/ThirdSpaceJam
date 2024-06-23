extends Node

class MusicFile:
	var _loader: AudioLoader
	var audio_stream: AudioStreamOggVorbis
	var BPM: int
	
	func _init(wav_file_path, bpm):
		_loader = AudioLoader.new()
		audio_stream = ResourceLoader.load(wav_file_path)
		audio_stream.loop = true
		BPM = bpm
		



const MUSIC_BUS: String = "Music"
var music_bus_idx: int

var stream_player: AudioStreamPlayer
var pitch_shift_effect: AudioEffectPitchShift
var amplify_effect: AudioEffectAmplify
var music_streams: Array[MusicFile]
var current_music: MusicFile

const music_files = [
	{
		"file": "res://Scenes/Audio/Music/HBD-1.ogg",
		"bpm": 140
	},
	{
		"file": "res://Scenes/Audio/Music/HBD-2.ogg",
		"bpm": 130
	},
	{
		"file": "res://Scenes/Audio/Music/HBD-3.ogg",
		"bpm": 128
	},
	{
		"file": "res://Scenes/Audio/Music/HBD-4.ogg",
		"bpm": 138
	}
]

func _set_pitch_effect():
	stream_player.pitch_scale = DifficultyManager.bpm / current_music.BPM
	pitch_shift_effect.pitch_scale = 1.0 + ( \
		stream_player.pitch_scale if stream_player.pitch_scale < 1.0 \
		else -(stream_player.pitch_scale - 1.0) \
	)
func _select_new_music():
	var new_music: MusicFile
	if music_files.size() > 1:
		# Loop until we get a new song
		while true:
			new_music = music_streams[randi_range(0, music_files.size() - 1)]
			if current_music != new_music:
				break
		current_music = new_music
	else:
		current_music = music_streams[0]
	

func _setup_stream_player():
	for i in music_files.size():
		music_streams.append(MusicFile.new(music_files[i].file, music_files[i].bpm))
	_select_new_music()
	
	stream_player = AudioStreamPlayer.new()
	stream_player.bus = MUSIC_BUS
	stream_player.stream = current_music.audio_stream
	
	get_parent().add_child(stream_player)
	music_bus_idx = AudioServer.get_bus_index(MUSIC_BUS)
	pitch_shift_effect = AudioServer.get_bus_effect(music_bus_idx, 0)
	amplify_effect = AudioServer.get_bus_effect(music_bus_idx, 1)
	_set_pitch_effect()
	stream_player.play()

func _ready():
	call_deferred("_setup_stream_player")
	
func _process(_delta):
	pass


func _on_spit_meter_gameover():
	var tween = create_tween()
	tween.tween_property(amplify_effect, "volume_db", linear_to_db(0.0), 1.0)
