extends Node3D
@export var damage: int = 10
@export var isActive: bool
@export var bullet: RigidBody3D

func fire() -> void:
#	calculate vector based on camera direction
	bullet.add_constant_force(Vector3(0, 5, 100))
	pass

func _on_bullet_area_entered(area: Area3D) -> void:
	if isActive:
		pass
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
