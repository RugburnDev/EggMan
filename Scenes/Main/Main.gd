class_name Main
extends Control

const LEADERBOARD_ENTRY = preload("res://Scenes/Main/LeaderboardEntry/LeaderboardEntry.tscn")

@onready var leaderboard_sc: ScrollContainer = $MarginContainer/LeaderboardSC
@onready var leaderboard_vb: VBoxContainer = $MarginContainer/LeaderboardSC/LeaderboardVB


func _ready() -> void:
	get_tree().paused = false
	_build_leaderboard()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		GameManager.change_scene_to_game()


func _build_leaderboard() -> void:
	for highscore : HighScore in GameManager.get_highscores():
		var leaderbord_entry = LEADERBOARD_ENTRY.instantiate()
		leaderbord_entry.initialize(highscore._initials, highscore._score, highscore._date)
		leaderboard_vb.add_child(leaderbord_entry)
