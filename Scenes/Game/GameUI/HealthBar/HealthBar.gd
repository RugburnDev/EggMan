class_name HealthBar
extends ProgressBar

@export var _healthy_color : Color = Color("009e00")
@export var _mid_health_color : Color = Color("ccb221")
@export var _critical_health_color : Color = Color("bf000a")

var _health : int
var fill_stylebox : StyleBox = get_theme_stylebox("fill", "ProgressBar")


func _ready() -> void:
	_health = int(max_value)
	value = _health
	
	fill_stylebox = get_theme_stylebox("fill", "ProgressBar")
	_set_color()


func set_health(val:int) -> void:
	_health = val
	value = _health
	_set_color()


func take_damage(damage:int) -> void:
	_health = max(0, _health - damage)
	_update_bar()
	if _health <= 0:
		_die()


func restore_health(restore:int) -> void:
	_health = min(max_value, _health + restore)
	_update_bar()
	
func _update_bar() -> void:
	value = _health
	_set_color()


func _set_color() -> void:
	var health_percent : float = _health / max_value
	if health_percent >= .7:
		fill_stylebox.bg_color = _healthy_color
	elif health_percent < .7 and health_percent > 0.3:
		fill_stylebox.bg_color = _mid_health_color
	else:
		fill_stylebox.bg_color = _critical_health_color


func _die() -> void:
	SignalHub.emit_on_player_died()
	get_tree().paused = true
