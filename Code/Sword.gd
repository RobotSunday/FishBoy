extends AnimatedSprite

export(float) var max_cooldown

var attack
var cooldown = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = true
	$CollisionShape2D/SwordSprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attack = Input.is_action_pressed("Attack")
	if attack and cooldown <= 0:
		$AnimationPlayer.play("sword_swing")
		cooldown = max_cooldown
	
	if cooldown > 0:
		cooldown -= delta




func _on_Weapon_area_entered(area):
	pass # Replace with function body.


func _on_Weapon_body_entered(body):
	if body.name == "Enemy":
		body.health -= 10


func _on_AnimationPlayer_animation_finished(anim_name):
	$CollisionShape2D.disabled = true
	$CollisionShape2D/SwordSprite.visible = false
