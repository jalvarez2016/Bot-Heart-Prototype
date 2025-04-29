extends Node3D
@export var ArmController: Node3D
@export var cooldown: Timer
var preloadedBullet = preload("res://Player/BaseParts/SFX/Bullet.tscn")
var shooting: bool = false

func shoot() -> void:
	if ArmController.isGun:
#		activate bullet
		var bullet = preloadedBullet.instantiate()
		get_tree().root.get_child(0).add_child(bullet)
		bullet.global_position = global_position
		bullet.fire()
		shooting = true
		cooldown.start()
		pass

func stop_shooting() -> void:
	if ArmController.isGun:
		shooting = false


func _on_timer_timeout() -> void:
	if shooting:
		shoot()
	pass # Replace with function body.
