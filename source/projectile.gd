extends Area2D

const SPEED = 500
var direction = Vector2.ZERO

func _ready():
	if direction == Vector2.ZERO:
		queue_free()  # Prevent stuck projectiles

func _process(delta):
	position += direction * SPEED * delta  # Move in the assigned direction

func _on_body_entered(body):
	if body.name != "game":  
		queue_free()
