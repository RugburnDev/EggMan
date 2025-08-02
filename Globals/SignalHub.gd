extends Node

signal _on_egg_broke()
signal _on_egg_caught()
signal _on_player_died()
signal _on_high_score()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func emit_on_high_score() -> void:
	if GameManager.DEBUG: print("emit_on_high_score")
	_on_high_score.emit()


func emit_on_egg_broke() -> void:
	if GameManager.DEBUG: print("emit_on_egg_broke")
	_on_egg_broke.emit()


func emit_on_egg_caught() -> void:
	if GameManager.DEBUG: print("emit_on_egg_caught")
	_on_egg_caught.emit()


func emit_on_player_died():
	if GameManager.DEBUG: print("emit_on_player_died")
	_on_player_died.emit()
