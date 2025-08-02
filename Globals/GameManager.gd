extends Node

const DEBUG : bool = true
const GAME : PackedScene = preload("res://Scenes/Game/Game.tscn")
const MAIN : PackedScene = preload("res://Scenes/Main/Main.tscn")
const SCORE_FILE = "user://score_data.res"

var _player_ref : Player
var fall_speed_multiplier : float = 1.0
var _score : int = 0
var _high_scores : Highscores



#region built-ins
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if ResourceLoader.exists(SCORE_FILE):
		_high_scores = ResourceLoader.load(SCORE_FILE)
	else:
		_high_scores = Highscores.new()


func _enter_tree() -> void:
	SignalHub._on_egg_caught.connect(_on_egg_caught)
#region

#region game-navigation
func change_scene_to_main() -> void:
	get_tree().change_scene_to_packed(MAIN)


func change_scene_to_game() -> void:
	_score = 0
	get_tree().change_scene_to_packed(GAME)
#endregion

#region score_management
func is_leaderboard_score() -> bool:
	return _score > 0 and _high_scores.is_leaderboard_score(_score)


func save_score(initials:String) -> void:
	_high_scores.save_score(_score, initials)
	ResourceSaver.save(_high_scores, SCORE_FILE)


func get_highscores() -> Array[HighScore]:
	return _high_scores.get_highscores_sorted()


func _on_egg_caught() -> void:
	_score += 1


func get_score() -> int:
	return _score
#endregion

#region player_info
func set_player_ref() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player_ref:
		push_error("PLAYER NOT FOUND")


func get_player() -> Player:
	return _player_ref


func get_player_state() -> Player.State:
	return _player_ref.get_player_state()
#endregion
