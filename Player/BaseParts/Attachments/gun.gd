extends Node3D
@export var isActive: bool = false
@export var ArmController: Node3D
@export var animator: AnimationPlayer
@export var cooldown: Timer
@export var bulletSpawnPoint: Marker3D
@export var preloadedBullet: Resource = preload("res://Player/BaseParts/SFX/Bullet.tscn")
var shooting: bool = false


func toggle_active() -> void:
	isActive = !isActive
	print("activate")


func shoot() -> void:
	if !isActive:
		return
	if ArmController.isGun:
		print('shootin')
		animator.play('Arm Shoot')
		var bullet = preloadedBullet.instantiate()
		get_tree().root.get_child(0).add_child(bullet)
		bullet.global_transform = bulletSpawnPoint.global_transform

		bullet.fire()
		shooting = true
		cooldown.start()


func stop_shooting() -> void:
	if !isActive:
		return
	if ArmController.isGun:
		print('stop shooting')
		shooting = false
		animator.play('Arm Idle')


func _on_timer_timeout() -> void:
	if shooting:
		print('timer ran out')
		shoot()
	pass # Replace with function body.
