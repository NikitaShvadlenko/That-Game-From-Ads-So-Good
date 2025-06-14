extends Node2D

@export var zombie_scene: PackedScene
@export var spawn_interval: float = 0.3  
@export var spawn_area_width: float = 600.0
@export var spawn_y: float = -100.0

var spawn_timer := 0.0

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_timer = spawn_interval
		spawn_zombie()

func spawn_zombie():
	var zombie = zombie_scene.instantiate()
	
	# x is relative, y is exactly where the spawner is
	var x = randf_range(-spawn_area_width / 2, spawn_area_width / 2)
	zombie.position = global_position + Vector2(x, 0)

	get_tree().current_scene.add_child(zombie)
