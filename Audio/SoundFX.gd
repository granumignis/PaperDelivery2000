extends Node

var sounds_path = "res://Audio/"
var menu_visited_once = false

var sounds = {	
	"announcer-paperdelivery2000_version1" : load(sounds_path +  "announcer-paperdelivery2000_version1.wav"),
	"announcer-paperdelivery2000_version2" : load(sounds_path +  "announcer-paperdelivery2000_version2.wav"),
	"announcer-paperdelivery2000_version3" : load(sounds_path +  "announcer-paperdelivery2000_version3.wav"),
	"buleep_version1" : load(sounds_path +  "buleep_version1.wav"),
	"menubeep_version1" : load(sounds_path +  "menubeep_version1.wav"),
	"menublip_version2" : load(sounds_path +  "menublip_version2.wav"),
	"menublip_version" : load(sounds_path +  "menublip_version.wav"),
	"menubloop_version1" : load(sounds_path +  "menubloop_version1.wav"),
	"paperthrow" : load(sounds_path +  "paperthrow.wav"),
	"paperdeliveredsoundeffect" : load(sounds_path +  "paperdeliveredsoundeffect.wav"),
	"routecomplete" : load(sounds_path +  "routecomplete.wav"),
	"sound_pickedupmorepapers" : load(sounds_path +  "sound_pickedupmorepapers.wav"),
	"announcer-routecomplete" : load(sounds_path +  "announcer-routecomplete.wav")
}


onready var sound_players = get_children()

func play(sound_string, pitch_scale = 1, volume_db = 0):
	for soundPlayer in sound_players:
		if not soundPlayer.playing:
			soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			match sound_string:
				"announcer-paperdelivery2000_version1":
					if menu_visited_once == false:
						print("Playing audio file (welcome): " + sound_string)
						soundPlayer.play()
						menu_visited_once = true
						print("We won't play the menu greeting again")
				"announcer-paperdelivery2000_version2":
					if menu_visited_once == false:
						print("Playing audio file (welcome): " + sound_string)
						soundPlayer.play()
						menu_visited_once = true
						print("We won't play the menu greeting again")
				"announcer-paperdelivery2000_version3":
					if menu_visited_once == false:
						print("Playing audio file (welcome): " + sound_string)
						soundPlayer.play()
						menu_visited_once = true
						print("We won't play the menu greeting again")
				_:
					print("Playing any old sound: " + sound_string)
					soundPlayer.play()
			return
	print("Too many sounds playing at once")
