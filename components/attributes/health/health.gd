extends Component
class_name HealthComponent

@export var rot : float

# Settings
@export var starting_health : float
@export var max_health : float
@export var min_health : float

# Internal state
var current_health : float

# Signals
signal took_damage(original_health, new_health, damage)
signal died

# Lifecycle
func _ready() -> void:
	$Sprite2D.rotation = rot
	current_health = starting_health

# API
func damage(value : float):
	var original_health = current_health
	current_health -= value
	took_damage.emit(original_health, current_health, value)
	if current_health <= 0:
		died.emit()
