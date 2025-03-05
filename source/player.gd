extends CharacterBody2D

const SPEED = 200
const ROTATION_SPEED = 2.0

@onready var anim_player = $Sprite2D/AnimationPlayer
@onready var camera: Camera2D = $Camera2D 

func _ready():
	anim_player.play("idle")

func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_key_pressed(KEY_Q):
		camera.rotation_degrees -= ROTATION_SPEED
	if Input.is_key_pressed(KEY_E):
		camera.rotation_degrees += ROTATION_SPEED
	if Input.is_key_pressed(KEY_Z):
		camera.rotation_degrees = 0

	rotation_degrees = camera.rotation_degrees  

	var camera_up = Vector2.UP.rotated(rotation)
	var camera_right = Vector2.RIGHT.rotated(rotation)

	if Input.is_key_pressed(KEY_W):  
		direction += camera_up
	if Input.is_key_pressed(KEY_S):  
		direction -= camera_up
	if Input.is_key_pressed(KEY_A):  
		direction -= camera_right
	if Input.is_key_pressed(KEY_D):  
		direction += camera_right

	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()

	if direction != Vector2.ZERO:
		if anim_player.current_animation != "walk":
			anim_player.play("walk")
	else:
		if anim_player.current_animation != "idle":
			anim_player.play("idle")
