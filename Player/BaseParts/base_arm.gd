extends Node3D
@export var armType: String

var type: String = 'arm'
var player: Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player = body
		player.ArmController.loadNewArm(armType, self)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player.ArmController.unLoadNewArm()
		player = null
