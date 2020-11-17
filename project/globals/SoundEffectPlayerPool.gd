extends Node

const POOL_SIZE := 8
const BUS := "master"

const SOUND_EFFECTS := {
	"impact1": preload("res://sfx/sfx_sounds_impact1.wav")
}

var avalible := []

func _ready() -> void:
	for i in POOL_SIZE:
		var player := AudioStreamPlayer.new()
		add_child(player)
		avalible.append(player)
		player.connect("finished",  self, "_on_player_finished", [player])
		player.bus = BUS

func _on_player_finished(player: AudioStreamPlayer) -> void:
	avalible.append(player)

func play(sound_name: String, volume: float = 0) -> void:
	if !avalible.empty() && SOUND_EFFECTS.has(sound_name):
		var player: AudioStreamPlayer = avalible.pop_back()
		player.stream = SOUND_EFFECTS[sound_name]
		player.volume_db = volume
		player.play()
