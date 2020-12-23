extends Node2D

var attack_damage
export(float) var attack_speed
var attack_range

func do_attack():
	pass

func _ready():
	$AttackSpeed.wait_time = attack_speed
