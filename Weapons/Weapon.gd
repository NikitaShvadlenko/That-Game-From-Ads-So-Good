extends Node

class_name Weapon

@onready var manager: GameManager = get_tree().current_scene.get_node("GameManager")
@onready var scene_root := get_tree().current_scene

# Exported properties all weapons might share
@export var fire_rate: float = 0.2  # Seconds between shots
@export var bullet_scene: PackedScene

# Optional cooldown timer
var _cooldown := 0.0
var fire_rate_multiplier := 1.0

func _ready() -> void:
	assert(bullet_scene != null, "bullet_scene must be assigned.")
	assert(owner != null, "Weapon owner must be set.")
	assert(manager != null, "GameManager node not found in current scene.")
	assert(scene_root != null, "Scene root is null. The node must be in scene tree.")
	manager.connect("fire_rate_multiplier_changed", Callable(self, "_on_fire_rate_changed"))
	fire_rate_multiplier = manager.fire_rate_multiplier

func _process(delta: float) -> void:
	if _cooldown > 0.0:
		_cooldown -= delta

# Abstract fire method — override in child classes
func fire():
	if _cooldown > 0.0:
		return
	_cooldown = fire_rate
	_fire_bullet()

# Can be overridden for multi-bullet or spread fire
func _fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = owner.global_position - Vector2(-50, 30)
	bullet.velocity = Vector2(0, -1) * bullet.speed
	bullet.connect("hit_target", Callable(manager, "_on_bullet_hit"))
	scene_root.add_child(bullet)

func _on_fire_rate_changed(new_multiplier: float) -> void:
	fire_rate_multiplier = new_multiplier
