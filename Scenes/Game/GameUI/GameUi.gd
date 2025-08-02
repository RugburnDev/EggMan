class_name GameUi
extends Control

const DEFEAT = preload("res://assets/sounds/ME OGG/ME_-_defeat_01.ogg")
const VICTORY = preload("res://assets/sounds/ME OGG/ME_-_victory_04.ogg")

@export var _max_health : int = 100
@export var _broken_egg_cost : int = 25
@export var _eaten_egg_regen : int = 5

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var health_bar: HealthBar = $MarginContainer/HealthBar
@onready var music: AudioStreamPlayer = $Music
@onready var game_over_overlay: Control = $GameOverOverlay
@onready var fade: ColorRect = $GameOverOverlay/Fade
@onready var paused_overlay: Control = $PausedOverlay
@onready var highscore_overlay: Control = $HighscoreOverlay
@onready var user_initials: LineEdit = $HighscoreOverlay/VBoxContainer/UserInitials
@onready var game_over_esc_label: Label = $GameOverOverlay/VBoxContainer/GameOverEscLabel


func _ready() -> void:
	health_bar.max_value = _max_health
	health_bar.set_health(_max_health)


func _enter_tree() -> void:
	SignalHub._on_egg_caught.connect(_on_egg_caught)
	SignalHub._on_egg_broke.connect(_on_egg_broke)
	SignalHub._on_player_died.connect(_on_player_died)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		paused_overlay.visible = !paused_overlay.visible
	elif event.is_action_pressed("exit") and (paused_overlay.visible or game_over_overlay.visible):
		if paused_overlay.visible and GameManager.is_leaderboard_score():
			paused_overlay.visible = false
			_process_highscore()
		else:
			GameManager.change_scene_to_main()


func _on_player_died() -> void:
	if GameManager.is_leaderboard_score():
		_process_highscore()
	else:
		_process_gameover()


func _process_highscore() -> void:
	_play_highscore_audio()
	_show_highscore()


func _show_highscore() -> void:
	highscore_overlay.show()
	user_initials.grab_focus()


func _play_highscore_audio() -> void:
	music.stop()
	music.stream = VICTORY
	music.play()


func _process_gameover() -> void:
	_play_gameover_audio()
	_show_gameover()


func _play_gameover_audio() -> void:
	music.stop()
	music.stream = DEFEAT
	music.play()
	
	
func _show_gameover() -> void:
	game_over_overlay.show()
	var tween : Tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,1),9)
	tween.tween_property(game_over_esc_label, "modulate", Color(1,1,1,1),1)
	tween.play()


func _on_egg_caught() -> void:
	call_deferred("_update_score_label")
	health_bar.restore_health(_eaten_egg_regen)
	

func _update_score_label() -> void:
	score_label.text = "%03d" % GameManager.get_score()
	

func _on_egg_broke() -> void:
	health_bar.take_damage(_broken_egg_cost)


func _on_save_score_button_pressed() -> void:
	GameManager.save_score(user_initials.text.to_upper().substr(0,3))
	highscore_overlay.hide()
	_process_gameover()
