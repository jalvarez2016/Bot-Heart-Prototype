extends Node3D

@export var LeftArmAnchor: Marker3D
@export var RightArmAnchor: Marker3D

var defaultArm = preload("res://Player/BaseParts/Attachments/BaseArm.tscn")
var LeftArmAnimator: AnimationPlayer
var RightArmAnimator: AnimationPlayer

var leftArm: Node3D
var rightArm: Node3D


func addLeftArm() -> void:
	var arm = defaultArm.instantiate()
	LeftArmAnchor.add_child(arm)
	leftArm = arm
	arm.isLeftArm = true
	arm.set_arms()


func addRightArm() -> void:
	var arm = defaultArm.instantiate()
	RightArmAnchor.add_child(arm)
	rightArm = arm
	arm.isLeftArm = false
	arm.set_arms()

func action(actionType: String) -> void:
	if leftArm:
		leftArm.action(actionType)
	else:
		print('missing left arm')
	if rightArm:
		rightArm.action(actionType)
	else:
		print('missing right arm')


func action_stop(actionType: String) -> void:
	if leftArm:
		leftArm.action_stop(actionType)
	else:
		print('missing left arm')
	if rightArm:
		rightArm.action_stop(actionType)
	else:
		print('missing right arm')
	
