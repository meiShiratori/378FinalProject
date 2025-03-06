extends CharacterBody2D

const SPEED = 200  
const ROTATION_SPEED = 2.0  
const SHOOT_COOLDOWN = 0.3  

@onready var anim_player = $Sprite2D/AnimationPlayer
@onready var camera: Camera2D = $Camera2D  
@onready var game = get_tree().current_scene  
@onready var projectile_scene = preload("res://Projectile.tscn")

var can_shoot = true  

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

	velocity = direction.normalized() * SPEED
	move_and_slide()

	anim_player.play("walk" if direction != Vector2.ZERO else "idle")

	if can_shoot and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shoot_projectile()

	z_index = int(global_position.y)

func shoot_projectile():
	can_shoot = false  
	var projectile = projectile_scene.instantiate()
	projectile.position = global_position  
	
	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	projectile.direction = direction_to_mouse
	projectile.rotation = direction_to_mouse.angle() + PI/2

	game.add_child(projectile)

	await get_tree().create_timer(SHOOT_COOLDOWN).timeout  
	can_shoot = true  
