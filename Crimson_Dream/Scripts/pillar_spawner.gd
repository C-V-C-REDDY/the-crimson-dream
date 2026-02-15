class_name  PillarSpawner extends Node

var pillar: PackedScene = preload("res://Scenes/pillar.tscn")
@export var pipe_spped: int = -150
@export_range (0.0, 1.0) var spawn_margin_top: float = 0.15
@export_range (0.0, 1.0) var spawn_margin_bottom: float = 0.30
@onready var spawn_timer: Timer = $SpawnTimer

func spawn_pipe() -> void:

		
	var Pillar = pillar.instantiate()
	add_child(Pillar)
	
	var viewport_size = get_viewport().get_visible_rect().size
	
	
	Pillar.position.x = viewport_size.x
	
	var min_y = viewport_size.y * spawn_margin_top
	var max_y = viewport_size.y * spawn_margin_bottom
	
	Pillar.position.y = randf_range(min_y, max_y)
	
	Pillar.set_speed(-150)
	
	
func stop() -> void:
	spawn_timer.stop()
	for pipe in get_children():
		if pipe is Pipe:
			pipe.set_speed(0)
			
			
func start_spawning_pillars() -> void:
	spawn_timer.start()
	
