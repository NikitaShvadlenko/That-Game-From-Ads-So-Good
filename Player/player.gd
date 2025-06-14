extends CharacterBody2D
@export var bullet_scene: PackedScene

@export var speed: float = 200.0
var input_direction := Vector2.ZERO

func _process_input():
	input_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_just_pressed("fire"):
		fire_bullet()

func _physics_process(_delta):
	_process_input()
	velocity = input_direction.normalized() * speed
	move_and_slide()
	
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func fire_bullet():
	var manager = get_tree().current_scene.get_node("GameManager")
	manager.spawn_bullet(global_position - Vector2(0, 8), Vector2(0, -1) * 600)
