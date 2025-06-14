extends CharacterBody2D

@export var speed: float = 50.0
@export var health: float = 50.0
@export var max_knockback := 800.0

var knockback_velocity := Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if knockback_velocity.length() > 1.0:
		velocity = knockback_velocity
		knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, delta * 5.0)
	else:
		velocity = Vector2(0, speed)

	move_and_slide()

func _update_health():
	$Label.text = str(ceil(health))
	
func take_damage(amount: float, from_position: Vector2, knockback: float):
	health -= amount
	_update_health()
	apply_knockback(from_position, knockback)
	if health <= 0:
		die()

func apply_knockback(from_position: Vector2, strength: float) -> void:
	var direction = (global_position - from_position).normalized()
	knockback_velocity += direction * strength

	if knockback_velocity.length() > max_knockback:
		knockback_velocity = knockback_velocity.normalized() * max_knockback

func die():
	queue_free()
