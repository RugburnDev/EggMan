class_name HighScore
extends Resource


@export var _score : int
@export var _date : String
@export var _initials : String


func initialize(score:int, initials:String) -> void:
	_score = score
	_initials = initials
	_date = Time.get_datetime_string_from_system(true)
