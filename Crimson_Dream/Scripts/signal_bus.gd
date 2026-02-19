extends Node


signal game_started
signal score_updated(new_score: int)
signal crow_crashed


const SAVE_FILE_PATH = "user://highscore.save"
var shake_strength : float = 0.0
var shake_fade : float = 15 

var score: int = 0
var high_score: int = 0
var rewards = {
	5: {"name" : "Green Shard" , "tex": preload("res://sprites/output-onlinepngtools (8).png")},
	15: {"name": "Purple Shard" , "tex": preload("res://sprites/output-onlinepngtools (6).png")},
	30: {"name": "Blood Feather" , "tex": preload("res://sprites/output-onlinepngtools (9).png")},
	50: {"name":"Elite Hourse" , "tex": preload("res://sprites/output-onlinepngtools (7).png")}
}
func get_reward_for_score(score: int):
	var best_reward = null
	#We check each required. Since dictionaries aren't always ordered,
	#we sort the keys to check from lowest to highest.
	var thresholds = rewards.keys()
	thresholds.sort()
	
	for amount in thresholds:
		if score >= amount:
			best_reward = rewards[amount]
	return best_reward


func _ready() -> void:
	load_high_score()

	
func load_high_score() -> void:
	#Check if file exists
	if FileAccess.file_exists(SAVE_FILE_PATH):
		# Now open in Read mode
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			high_score = file.get_var()
		else:
			high_score = 0
			
			
func save_high_score() -> void:
	# 1. Open file in write mode
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(high_score)
		
		
func check_high_score() -> void:
	if score > high_score:
		high_score = score
		save_high_score()
		
		
func add_point() -> void:
	score += 1
	score_updated.emit(score)



		
		
func reset_score() -> void:
	score = 0
	score_updated.emit(score)

	

		
		
	
