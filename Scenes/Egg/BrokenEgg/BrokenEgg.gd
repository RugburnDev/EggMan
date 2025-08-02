class_name BrokenEgg
extends AnimatedSprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $sound


func _on_animation_finished() -> void:
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_away")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
