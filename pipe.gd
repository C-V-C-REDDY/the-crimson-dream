class_name Pipe extends Node2D

var speed: float = 0.0

func set_speed(new_speed: float) -> void:
	speed = new_speed
	
	
func _process(delta: float) -> void:
	position.x += speed * delta


func _on_scorearea_body_entered(body: Node2D) -> void:
	if body.name == "Bird":
		SignalBus.add_point()


func _on_toppipe_body_entered(body: Node2D) -> void:
	if body.name == "Bird":
		SignalBus.bird_crashed.emit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
