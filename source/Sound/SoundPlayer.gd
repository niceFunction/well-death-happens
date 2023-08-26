extends Node

const hurt = preload("res://assets/Sound/Hit_Hurt.wav")
const jump = preload("res://assets/Sound/Jump2.wav")

onready var audio_players = $AudioPlayers

func play_sound(sound):
	for audio_stream_player in audio_players.get_children():
		if not audio_stream_player.playing:
			audio_stream_player.stream = sound
			audio_stream_player.play()
			break
