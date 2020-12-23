extends Area2D
signal hit_enemy

export(float) var max_cooldown

var attack
var cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attack = Input.is_action_pressed("Attack")
	if attack and cooldown <= 0:
		$AnimationPlayer.play("sword_swing")
		cooldown = max_cooldown
	
	if cooldown > 0:
		cooldown -= delta
