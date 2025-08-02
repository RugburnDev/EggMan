class_name LeaderboardEntry
extends HBoxContainer

@onready var initials_label: Label = $InitialsLabel
@onready var score_label: Label = $ScoreLabel
@onready var date_label: Label = $DateLabel

var _initials : String 
var _score : int
var _date : String


func _ready() -> void:
	initials_label.text = "%-3s" % _initials
	score_label.text = "%03d" % _score
	date_label.text = _date
	
	
func initialize(initials:String, score:int, date:String) -> void:
	_initials = initials
	_score = score
	_date = date
