extends Node3D
@export var damage: int = 10
@export var isActive: bool
@export var bulletDirection: Marker3D
@export var bullet: RigidBody3D
@export var dropRef: String

func fire() -> void:
	var generalDirection:= bulletDirection.global_position - self.global_position
	bullet.add_constant_force(Vector3(generalDirection.x * 10, generalDirection.y + 8, generalDirection.z * 10))

func _on_bullet_area_entered(area: Area3D) -> void:
	if isActive:
		pass
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
