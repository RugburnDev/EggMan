extends Node2D


const EGG = preload("res://Scenes/Egg/Egg.tscn")

@onready var egg_timer: Timer = $EggTimer
@onready var egg_container: Node = $EggContainer
@onready var left_marker: Marker2D = $EggDropLimits/LeftMarker
@onready var right_marker: Marker2D = $EggDropLimits/RightMarker


func _ready() -> void:
	_drop_egg()


func _drop_egg() -> void:
	var egg : Egg = EGG.instantiate()
	egg.global_position = left_marker.global_position
	egg.global_position.x = randf_range(left_marker.global_position.x, right_marker.global_position.x)
	egg_container.add_child(egg)


func _on_egg_timer_timeout() -> void:
	_drop_egg()
	egg_timer.wait_time = randf_range(1.5, 3.5)
	egg_timer.start()
