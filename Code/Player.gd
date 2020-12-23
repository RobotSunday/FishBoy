extends KinematicBody2D
export(float) var run_max_speed = 200
export(float) var run_accel = 50
export(float) var jump_duration_to_height = 0.75
export(float) var jump_height = 100
export(float, 0, 1) var ground_friction = 0.27
export(float, 0, 1) var air_friction = 0.05

var grounded = true
var up_force
var velocity = Vector2()
var gravity
var jump
var left
var right
var down
var facing_left = true
var crouching_offset = Vector2(0,0.005)
var crouching_coll_shape = CircleShape2D.new() 
var current_shape
var small_collider = false

func _ready():
	crouching_coll_shape.radius = 38
	current_shape = $CollisionShape2D.shape
	gravity = (2*jump_height) / pow(jump_duration_to_height,2) 
	up_force =  (-2*jump_height) / jump_duration_to_height

func _process(delta):
	jump = Input.is_action_pressed("ui_up")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	down = Input.is_action_pressed("ui_down")
	
	$Sprite.flip_h = facing_left
	
	if left:
		facing_left = true
		$Sprite.play("run")
	elif right:
		facing_left = false
		$Sprite.play("run")
	elif down:
		$Sprite.play("duck")
	else:
		if grounded:
			$Sprite.play("default")
		else:
			$Sprite.play("jump")
	


func _physics_process(delta):
	var gravity_modifier
	if velocity.y > 0:
		gravity_modifier = 1.75
	else:
		gravity_modifier = 1
		
	velocity.y += gravity * gravity_modifier * delta
	
	
	if jump and grounded:
		grounded = false
		velocity.y = up_force
	
	if right:
		velocity.x = min(velocity.x + run_accel, run_max_speed)
		$Sprite.offset = Vector2()
		$CollisionShape2D.shape = current_shape
	elif left:
		velocity.x = max(velocity.x - run_accel, -run_max_speed)
		$Sprite.offset = Vector2()
		$CollisionShape2D.shape = current_shape
	elif down:
		velocity.x = lerp(velocity.x, 0, ground_friction * 1.75)
		if !left and !right:
			$Sprite.offset = crouching_offset
			$CollisionShape2D.shape = crouching_coll_shape
	else:
		$Sprite.offset = Vector2()
		$CollisionShape2D.shape = current_shape
		if grounded:
			velocity.x = lerp(velocity.x, 0, ground_friction)
		else:
			velocity.x = lerp(velocity.x, 0, air_friction)
	
	if !grounded and is_on_floor():
		grounded = true
	velocity = move_and_slide(velocity, Vector2(0,-1))



