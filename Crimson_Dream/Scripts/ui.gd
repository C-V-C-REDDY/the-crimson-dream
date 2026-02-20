class_name UI extends CanvasLayer

@onready var points_container: HBoxContainer = $MarginContainer/PointsContainer
@onready var game_over_box: VBoxContainer = $"MarginContainer/GameOver Box"
@onready var round_score_container: HBoxContainer = $"MarginContainer/GameOver Box/Panel/RoundScoreContainer"
@onready var best_score_container: HBoxContainer = $"MarginContainer/GameOver Box/Panel/BestScoreContainer"
@onready var medal_texture: TextureRect = $"MarginContainer/GameOver Box/Panel/MedalTexture"

var digit_textures: Array[Texture2D] = [
	preload("res://sprites/0.png"),
	preload("res://sprites/1.png"),
	preload("res://sprites/2.png"),
	preload("res://sprites/3.png"),
	preload("res://sprites/4.png"),
	preload("res://sprites/5.png"),
	preload("res://sprites/6.png"),
	preload("res://sprites/7.png"),
	preload("res://sprites/8.png"),
	preload("res://sprites/9.png")
]

var medal_textures: Array[Texture2D] = [
	preload("res://sprites/output-onlinepngtools (8).png"),
	preload("res://sprites/output-onlinepngtools (6).png"),
	preload("res://sprites/output-onlinepngtools (9).png"),
	preload("res://sprites/output-onlinepngtools (7).png")
]

func set_container_score(score: int, container: HBoxContainer) -> void:
	for child in container.get_children():
		child.queue_free()
		
	var score_str = str(score)
	
	
	for digit_char in score_str:
		var digit_int = int(digit_char)
		
		var texture_rect = TextureRect.new()
		texture_rect.texture = digit_textures[digit_int]
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP
		
		container.add_child(texture_rect)
		
		
func upadate_gameplay_score(points: int) -> void:
	set_container_score(points,points_container)
	
func assign_medal(score: int) -> void:
	var reward = SignalBus.get_reward_for_score(score)
	#If the Brain found something, show it!
	if reward:
		medal_texture.texture = reward["tex"]
		medal_texture.visible = true
		print("Awarded: ", reward["name"] ) #This helps us debug in console
	else:
		medal_texture.visible = false
	
	
		
func on_game_over() -> void:
	game_over_box.visible = true
	
	set_container_score(SignalBus.score, round_score_container)
	
	set_container_score(SignalBus.high_score, best_score_container)
	assign_medal(SignalBus.score)

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func _ready() -> void:
	SignalBus.score_updated.connect(upadate_gameplay_score)
	
	set_container_score(0, points_container)
	game_over_box.visible = false
