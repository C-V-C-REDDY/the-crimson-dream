extends Camera2D

var shake_strength : float = 0.0
var shake_fade : float = 15.0 

func _ready() -> void:
	# The camera listens for the crash message from the SignalBus
	SignalBus.crow_crashed.connect(_on_crow_crashed)

func _on_crow_crashed() -> void:
	# When the crash happens, set the strength!
	shake_strength = 20.0 

func _process(delta: float) -> void:
	if shake_strength > 0:
		# Gradually fade the shaking
		shake_strength = lerp(shake_strength, 0.0, shake_fade * delta)
		
		# Apply the random vibration to the camera's offset
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		# Make sure it returns to exactly (0,0)
		offset = Vector2.ZERO
