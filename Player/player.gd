extends CharacterBody2D

@export var speed: float = 400.0
@onready var smg = $Smg

var input_direction := Vector2.ZERO

func _process_input():
	input_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("fire"):
		fire_bullet()

func _physics_process(_delta):
	_process_input()
	velocity = input_direction.normalized() * speed
	move_and_slide()
	
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func fire_bullet():
	smg.fire()
