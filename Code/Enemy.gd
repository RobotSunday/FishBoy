extends KinematicBody2D

var health
var velocity = Vector2()
var gravity

func _ready():
	health = 10
	gravity = 98

func _process(delta):
	if health <= 0:
		_die()

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = -50
	velocity = move_and_slide(velocity, Vector2(0,-1))

func _die():
	queue_free()
