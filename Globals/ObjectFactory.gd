extends Node

enum ObjectType{CRACKED_EGG}

const OBJECTS : Dictionary[ObjectType, PackedScene] = {
	ObjectType.CRACKED_EGG: preload("res://Scenes/Egg/BrokenEgg/BrokenEgg.tscn")
}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func create_object(type:ObjectType, pos:Vector2) -> void:
	var obj : Node2D = OBJECTS[type].instantiate()
	obj.global_position = pos
	add_child(obj)
