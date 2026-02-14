extends Node

@onready var swoosh_player: AudioStreamPlayer = $SwooshPlayer
@onready var die_player: AudioStreamPlayer = $DiePlayer
@onready var wing_player: AudioStreamPlayer = $WingPlayer
@onready var point_player: AudioStreamPlayer = $PointPlayer
@onready var hit_player: AudioStreamPlayer = $HitPlayer
@onready var bgm_player: AudioStreamPlayer2D = $BGMPlayer


func play_sorrow_music() -> void:
	bgm_player.play()
	#bgm_player.seek(30.0)
func stop_music() -> void:
	bgm_player.stop()

func play_wing() -> void:
	wing_player.play()
	
func play_swoosh() -> void:
	swoosh_player.play()
	
	
func play_point(_score: int) -> void:
	if _score == 0:
		return
	point_player.play()
	
	
func play_crashed_sequence() -> void:
	if hit_player.playing or die_player.playing:
		return
		
		
	hit_player.play()
	
	
	await get_tree().create_timer(0.3).timeout
	die_player.play()
	
	
	
	
func _ready() -> void:
	SignalBus.game_started.connect(play_swoosh)
	SignalBus.score_updated.connect(play_point)
	SignalBus.crow_crashed.connect(play_crashed_sequence)
	
