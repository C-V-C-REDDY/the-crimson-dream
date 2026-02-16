class_name PillarSpawner extends Node

# 1. SETTINGS (The DNA)
@export var pillar_scene: PackedScene = preload("res://Scenes/pillar.tscn")
@export var pipe_speed: int = -150
@export var spawn_interval: float = 1.5 # How many seconds between pipes
@export_range (0.0, 1.0) var spawn_margin_top: float = 0.2
@export_range (0.0, 1.0) var spawn_margin_bottom: float = 0.4

@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	# Set the timer wait time based on our export variable
	spawn_timer.wait_time = spawn_interval

func spawn_pipe() -> void:
	var new_pillar = pillar_scene.instantiate()
	add_child(new_pillar)
	
	# Logic: Get Screen Dimensions
	var viewport_size = get_viewport().get_visible_rect().size
	
	# Logic: Positioning
	new_pillar.position.x = viewport_size.x + 50 # Spawn slightly off-screen
	
	var min_y = viewport_size.y * spawn_margin_top
	var max_y = viewport_size.y * spawn_margin_bottom
	new_pillar.position.y = randf_range(min_y, max_y)
	
	# Logic: Handing over the speed
	if new_pillar.has_method("set_speed"):
		new_pillar.set_speed(pipe_speed)
	
func stop() -> void:
	spawn_timer.stop()
	# Tell all current pipes to freeze
	for pipe in get_children():
		if pipe.has_method("set_speed"):
			pipe.set_speed(0)

func start_spawning_pillars() -> void:
	spawn_timer.start()
