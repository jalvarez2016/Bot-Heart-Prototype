extends Node3D

@export var RightArm : bool
@export var LeftArm : bool
@export var RightLeg : bool
@export var LeftLeg : bool
@export var LegController: Node3D
@export var ArmController: Node3D

func _ready() -> void:
	if LeftLeg:
		LegController.addLeftLeg()
	if RightLeg:
		LegController.addRightLeg()
	if LeftArm:
		ArmController.addLeftArm()
	if RightArm:
		ArmController.addRightArm()
