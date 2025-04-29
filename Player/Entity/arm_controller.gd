extends Node3D

@export var LeftArmAnchor: Marker3D
@export var RightArmAnchor: Marker3D
@export var timer: Timer

var defaultArm = preload("res://Player/BaseParts/Attachments/BaseArm.tscn")
var LeftArmAnimator: AnimationPlayer
var RightArmAnimator: AnimationPlayer

var leftArm: Node3D
var rightArm: Node3D


func addLeftArm() -> void:
	var arm = defaultArm.instantiate()
	LeftArmAnchor.add_child(arm)
	leftArm = arm
	#LeftArmAnimator = arm.animator
	#LeftArmAnimator.play('Idle')


func addRightArm() -> void:
	var arm = defaultArm.instantiate()
	RightArmAnchor.add_child(arm)
	rightArm = arm
	#RightArmAnimator = arm.animator
	#RightArmAnimator.play('Idle')

func action(actionType: String) -> void:
	if leftArm:
		leftArm.action(actionType)
	else:
		print('missing left arm')


func action_stop(actionType: String) -> void:
	if leftArm:
		leftArm.action_stop(actionType)
	else:
		print('missing left arm')
	
