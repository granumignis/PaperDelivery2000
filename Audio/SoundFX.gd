extends Node

var sounds_path = "res://Audio/"

var sounds = {	
	"announcer-paperdelivery2000_version1" : load(sounds_path +  "announcer-paperdelivery2000_version1.wav"),
	"announcer-paperdelivery2000_version2" : load(sounds_path +  "announcer-paperdelivery2000_version2.wav"),
	"announcer-paperdelivery2000_version3" : load(sounds_path +  "announcer-paperdelivery2000_version3.wav")
}


onready var sound_players = get_children()

func play(sound_string, pitch_scale = 1, volume_db = 0):
	for soundPlayer in sound_players:
		if not soundPlayer.playing:
			soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			soundPlayer.play()
			return
	print("Too many sounds playing at once")

