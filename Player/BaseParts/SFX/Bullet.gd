extends Node3D
@export var damage: int = 10
@export var isActive: bool = true
@export var isEnemyBullet: bool = false
@export var bulletDirection: Marker3D
@export var bullet: RigidBody3D
@export var dropRef: String

func fire() -> void:
	var generalDirection:= bulletDirection.global_position - self.global_position
	bullet.add_constant_force(Vector3(generalDirection.x * 20, generalDirection.y + 8, generalDirection.z * 20))


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	if isActive:
		if body.is_in_group("Player") && isEnemyBullet:
			body.healthManager.loseHealth(damage)
			queue_free()
		elif body.is_in_group("Enemy") && !isEnemyBullet:
			body.healthManager.loseHealth(damage)
			queue_free()
