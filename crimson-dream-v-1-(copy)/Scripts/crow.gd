class_name Crow extends CharacterBody2D

const FLAP_FORCE: float = - 400.0
const MAX_FALL_SPEED: float = 600.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var instructions: Sprite2D = $Instructions
@onready var chidori_sparks: CPUParticles2D = $lightningSparks
@onready var line_2d: Line2D = $Line2D



var gravity: float = 900.0
var is_dead: bool = false
var is_game_started: bool = false

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
		
		
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	flap()
	if !is_game_started:
		return
	rotate_while_falling(delta)
	move_and_slide()
	
	
func flap() -> void:
	if Input.is_action_just_pressed("Flap"):
		if !is_game_started:
			is_game_started = true
			SignalBus.game_started.emit()
			var tween = create_tween()
			tween.tween_property(instructions,"modulate:a",0.0,0.5)
			tween.tween_callback(instructions.queue_free)
			
		if !is_dead:
			animated_sprite_2d.play("flap")
			velocity.y = FLAP_FORCE
			rotation = deg_to_rad(-15)
			collision_mask = 0
			AudioManager.play_wing()
 
	 
func rotate_while_falling(delta) -> void:
	if velocity.y > 0:
		rotation = lerp_angle(rotation,deg_to_rad(10), 10 * delta)
		
		
func die() -> void:
	is_dead = true
	
	$lightningSparks.emitting = true
	$Line2D.start_strike()
	velocity = Vector2.ZERO
	rotation = 0
	
	
	
func stop() -> void:
	animated_sprite_2d.stop()
	velocity = Vector2.ZERO
	die()
	gravity = 0
	
