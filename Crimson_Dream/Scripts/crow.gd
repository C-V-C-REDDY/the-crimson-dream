class_name Crow extends CharacterBody2D

# --- SETTINGS (Change these to tune the game feel) ---
@export var FLAP_FORCE: float = -400.0
@export var MAX_FALL_SPEED: float = 600.0
@export var GRAVITY: float = 900.0
@export var TILT_UP_DEG: float = -15.0
@export var TILT_DOWN_DEG: float = 10.0
@export var ROTATION_SPEED: float = 10.0

# --- NODES ---
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var instructions: Sprite2D = $Instructions

# --- STATE ---
var is_dead: bool = false
var is_game_started: bool = false





func _physics_process(delta: float) -> void:
	# 1. Handle Input (The "Brain")
	handle_input()
	
	# 2. Handle Physics (The "Body")
	if is_game_started and not is_dead:
		apply_gravity(delta)
		rotate_while_falling(delta)
		move_and_slide()

func handle_input() -> void:
	if Input.is_action_just_pressed("Flap") and not is_dead:
		if not is_game_started:
			start_game()
		
		# Perform the Flap
		velocity.y = FLAP_FORCE
		rotation = deg_to_rad(TILT_UP_DEG)
		animated_sprite_2d.play("flap")
		AudioManager.play_wing()

func start_game() -> void:
	is_game_started = true
	SignalBus.game_started.emit()
	var tween = create_tween()
	tween.tween_property(instructions, "modulate:a", 0.0, 0.5)
	tween.tween_callback(instructions.queue_free) # Cleaner than tween_callback

func apply_gravity(delta: float) -> void:
	velocity.y += GRAVITY * delta
	velocity.y = min(velocity.y, MAX_FALL_SPEED) # A pro way to write "don't exceed max"

func rotate_while_falling(delta: float) -> void:
	# Only tilt down if we are actually falling
	if velocity.y > 0:
		rotation = lerp_angle(rotation, deg_to_rad(TILT_DOWN_DEG), ROTATION_SPEED * delta)

func die() -> void:
	if is_dead: return # Don't die twice!
	is_dead = true
	$lightningSparks.emitting = true
	$Line2D.start_strike()
	animated_sprite_2d.stop()

	# We don't set gravity to 0 here so the bird falls to the ground!
func stop() -> void:
	animated_sprite_2d.stop()
	die()
