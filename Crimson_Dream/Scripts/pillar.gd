class_name Pillar extends Node2D

@onready var toppillar: Area2D = $Toppillar
@onready var bottompillar: Area2D = $Bottompillar
var current_gap: float = 125.0
var speed: float = 0.0

func set_gap_size(gap_distance: float) -> void:
	if is_inside_tree() and has_node("Toppillar"):
		_apply_gap()
	#We move the top pillar UP (negative Y) and bottom pillar DOWN (positive Y)
	#from the center point of the Pillar node.
	
	var top  = get_node("Toppillar")
	var bottom = get_node("Bottompillar")
	
	if top and bottom:
		top.position.y = -(current_gap / 2)
		bottom.position.y = (current_gap / 2)
	else:
		print("Error: Pillars not found in Pillar scene!") 

func set_speed(new_speed: float) -> void:
	speed = new_speed

	if is_inside_tree() and has_node("Toppillar"):
		_apply_gap()
func _apply_gap() -> void:
	var top = $Toppillar
	var bottom = $Bottompillar
	top.position.y = -(current_gap / 2)
	bottom.position.y = (current_gap / 2)
	
	
func _physics_process(delta: float) -> void:
	position.x += speed * delta


func _on_scorearea_body_entered(body: Node2D) -> void:
	if body.name == "Crow":
		SignalBus.add_point()


func _on_toppipe_body_entered(body: Node2D) -> void:
	if body.name == "Crow":
		SignalBus.crow_crashed.emit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
