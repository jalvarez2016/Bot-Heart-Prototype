extends Node3D
@export var isActive: bool = false
@export var ArmController: Node3D
@export var animator: AnimationPlayer
@export var cooldown: Timer
@export var bulletSpawnPoint: Marker3D
@export var preloadedBullet: Resource = preload("res://Player/BaseParts/SFX/Bullet.tscn")
@export var mainNode: Node3D
var shooting: bool = false


func toggle_active() -> void:
	isActive = !isActive


func shoot() -> void:
	if !isActive:
		return
	if ArmController.isGun:
		animator.play('Arm Shoot')
		var bullet: Node3D = preloadedBullet.instantiate()
		get_tree().root.get_child(0).add_child(bullet)
		bullet.isEnemyBullet = ArmController.isEnemyPart
		bullet.global_position = bulletSpawnPoint.global_position
		var generalMesh : Node3D =  mainNode
		bullet.rotation.y = - generalMesh.projectileRotation

		bullet.fire()
		shooting = true
		cooldown.start()


func stop_shooting() -> void:
	if !isActive:
		return
	if ArmController.isGun:
		shooting = false
		animator.play('Arm Idle')


func _on_timer_timeout() -> void:
	if shooting:
		shoot()
