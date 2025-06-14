extends Area2D
@export var speed: float = 600.0
@export var damage: float = 10.0
@export var knockback_strength: float = 0.9
@export var max_range: float = 1000.0
signal hit_target(bullet: Node, target: Node, damage: float, from_position: Vector2, knockback: float)

var origin: Vector2
var velocity := Vector2.ZERO

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_Bullet_body_entered"))
	origin = global_position

func _physics_process(delta: float) -> void:
	position += velocity * delta

	if global_position.distance_squared_to(origin) > max_range * max_range:
		queue_free()

func _on_Bullet_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		emit_signal("hit_target", self, body, damage, global_position, knockback_strength)
		queue_free()
