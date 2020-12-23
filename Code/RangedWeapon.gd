extends "res://Weapon.gd"

var projectile_scene = preload("res://Projectile.tscn")
var shoot

func do_attack():
	var projectile = projectile_scene.instance()
	add_child(projectile)
	projectile._set_dir(Vector2(1,0))
	projectile.speed = 20
	
func _process(delta):
	shoot = Input.is_action_pressed("Attack")
	
	if shoot and $AttackSpeed.is_stopped():
		do_attack()
		$AttackSpeed.start()
