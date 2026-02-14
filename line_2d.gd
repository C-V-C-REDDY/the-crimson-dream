extends Line2D

func _ready():
	hide() # Hide it until we die

func start_strike():
	show() # Show the lightning
	# Create a loop to make the lightning flicker for 0.5 seconds
	for i in range(12):
		generate_lightning()
		await get_tree().create_timer(0.05).timeout # High-speed flicker
	hide() # Disappear after the 'strike'

func generate_lightning():
	var points_count = 5
	var new_points = []
	for i in range(points_count):
		# Create random jagged offsets for the lightning effect
		new_points.append(Vector2(randf_range(-30, 30), randf_range(-30, 30)))
	points = new_points # Apply the jagged shape
