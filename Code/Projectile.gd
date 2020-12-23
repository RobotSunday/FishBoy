extends Area2D

var velocity
var speed = 20
var direction = Vector2()

func _set_dir(dir):
	direction = dir
	velocity = dir * speed


func _process(delta):
	velocity.y += 98 * delta
	position += velocity
