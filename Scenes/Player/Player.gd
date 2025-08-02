class_name Player
extends CharacterBody2D

enum State{IDLE, CATCH, MOVE_L, MOVE_R, GAMEOVER, EMOTE}
enum Emote{DANCE}

const ANIM : Dictionary = {
	State.IDLE: "idle",
	State.CATCH: "idle_raised",
	State.MOVE_L: "move_left",
	State.MOVE_R: "move_right",
	State.GAMEOVER: "game_over", 
	State.EMOTE: {
		Emote.DANCE: "dance_1"
	}
}
const GROUP_NAME : String = "Player"


@onready var _anim: AnimatedSprite2D = $AnimatedSprite2D

@export var _player_speed: float = 250

var _state : State = State.IDLE
var _emote : Emote = Emote.DANCE

func _ready() -> void:
	add_to_group(GROUP_NAME)
	GameManager.set_player_ref()


func _enter_tree() -> void:
	SignalHub._on_player_died.connect(_on_player_died)


func _process(_delta:float) -> void:
	_process_movement()
	_process_state()
	_process_animation()
	move_and_slide()


func get_player_state() -> State:
	return _state


func _on_player_died() -> void:
	set_process(false)
	_state = State.GAMEOVER
	_process_animation()


func _process_movement() -> void:
	velocity = Vector2(Input.get_axis("move_left", "move_right")*_player_speed, 0)
	if !is_on_floor():
		velocity += get_gravity()


func _process_state() -> void:
	if is_zero_approx(velocity.x):
		if Input.is_action_pressed("catch"):
			_state = State.CATCH
		elif Input.is_action_pressed("emote"):
			_state = State.EMOTE
		else:
			_state = State.IDLE
	elif velocity.x > 0:
		_state = State.MOVE_R
	elif velocity.x < 0:
		_state = State.MOVE_L 
		
		
func _process_animation() -> void:
	if _state == State.EMOTE:
		if _anim.animation != ANIM[_state][_emote]:
			_anim.play(ANIM[_state][_emote])
	elif _anim.animation != ANIM[_state]:
		_anim.play(ANIM[_state])
