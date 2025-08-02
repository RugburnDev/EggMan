class_name Egg
extends Area2D

var _fall_speed : float = 100.0
@onready var sound: AudioStreamPlayer2D = $Sound


func _ready() -> void:
	_fall_speed *= GameManager.fall_speed_multiplier


func _process(delta:float) -> void:
	position.y += _fall_speed * delta


func _die(caught:bool) -> void:
	set_process(false)
	if caught:
		hide()
		sound.play()
		SignalHub.emit_on_egg_caught()
	else: 
		SignalHub.emit_on_egg_broke()
		ObjectFactory.create_object(ObjectFactory.ObjectType.CRACKED_EGG, global_position)
		queue_free()
	


func _on_area_entered(area: Area2D) -> void:
	if area is PlayerMouthArea and GameManager.get_player_state() == Player.State.CATCH:
		_die(true)


func _on_body_entered(_body: Node2D) -> void:
	_die(false)


func _on_sound_finished() -> void:
	queue_free()
