class_name Highscores
extends Resource

@export var _highscores : Array[HighScore]


func is_leaderboard_score(score:int) -> bool:
	if !get_highscores_sorted():
		return true
	return score >= get_highscores_sorted().back()._score


func save_score(score:int, initials:String) -> void:
	var highscore : HighScore = HighScore.new()
	highscore.initialize(score, initials)
	_highscores.push_front(highscore)


func get_highscores_sorted() -> Array[HighScore]:
	_highscores.sort_custom(_sort_highscores)
	return _highscores.slice(0,5)


func _sort_highscores(score_1:HighScore, score_2:HighScore, desc:bool=true) -> bool:
	if desc:
		if score_1._score > score_2._score:
			return true
		else: 
			return false
	else:
		if score_1._score < score_2._score:
			return true
		else: 
			return false
