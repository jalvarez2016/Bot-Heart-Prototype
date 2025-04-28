extends Node3D

@export var LeftArmAnchor: Marker3D
@export var RightArmAnchor: Marker3D
@export var timer: Timer

var defaultArm = preload("res://Player/BaseParts/Attachments/BaseArm.tscn")
var LeftArmAnimator: AnimationPlayer
var RightArmAnimator: AnimationPlayer


func addLeftArm() -> void:
	var arm = defaultArm.instantiate()
	LeftArmAnchor.add_child(arm)
	LeftArmAnimator = arm.animator
	LeftArmAnimator.play('Idle')


func addRightArm() -> void:
	var arm = defaultArm.instantiate()
	RightArmAnchor.add_child(arm)
	RightArmAnimator = arm.animator
	RightArmAnimator.play('Idle')
