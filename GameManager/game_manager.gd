extends Node

class_name GameManager

@export var fire_rate_multiplier := 0

signal fire_rate_multiplier_changed(new_multiplier: float)

func _on_bullet_hit(bullet: Node, target: Node, damage: float, from_position: Vector2, knockback: float) -> void:
	if target.has_method("take_damage"):
		target.take_damage(damage, from_position, knockback)

func spawn_bullet(position: Vector2, velocity: Vector2):
	var bullet = preload("res://Bullet/Bullet.tscn").instantiate()
	bullet.global_position = position
	bullet.velocity = velocity
	bullet.connect("hit_target", Callable(self, "_on_bullet_hit"))
	get_tree().current_scene.add_child(bullet)
