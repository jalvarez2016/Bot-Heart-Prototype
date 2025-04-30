extends Node3D

@export var RightArm : bool
@export var LeftArm : bool
@export var RightLeg : bool
@export var LeftLeg : bool
@export var LegController: Node3D
@export var ArmController: Node3D

@export var legType: String = "res://Player/BaseParts/Attachments/BaseLeg.tscn" #Absolute path to attachment scene
@export var armType:  String = "res://Player/BaseParts/Attachments/BaseArm.tscn" #Absolute path to attachment scene

func _ready() -> void:
	var leg = load(legType)
	var arm = load(armType)
	if LeftLeg:
		LegController.addLeftLeg(leg)
	if RightLeg:
		LegController.addRightLeg(leg)
	if LeftArm:
		ArmController.addLeftArm(arm)
	if RightArm:
		ArmController.addRightArm(arm)
