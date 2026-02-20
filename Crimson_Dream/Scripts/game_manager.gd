extends Node

@onready var bird: Crow = $"../Crow"
@onready var pillar_spawner: PillarSpawner = $"../PillarSpawner"
@onready var scrolling_ground: Node2D = $"../ScrollingGround"
@onready var fade: FadeEffect = $"../Fade"
@onready var ui: UI = $"../UI"
#@onready var lightning_sparks: CPUParticles2D = $lightningSparks

func on_game_started() -> void:
	pillar_spawner.start_spawning_pillars()
	AudioManager.stop_music()
	
func end_game() -> void:
	if fade != null:
		fade.play()
		set_physics_process(false)
	
	scrolling_ground.stop()
	bird.die()
	pillar_spawner.stop()
	SignalBus.check_high_score()
	ui.on_game_over()
	
func _ready() -> void:
	SignalBus.reset_score()
	SignalBus.game_started.connect(on_game_started)
	SignalBus.crow_crashed.connect(end_game)
	AudioManager.play_sorrow_music()
