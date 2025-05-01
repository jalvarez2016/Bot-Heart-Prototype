extends Node3D

@export var LeftArmAnchor: Marker3D
@export var RightArmAnchor: Marker3D
@export var mesh: MeshInstance3D

var defaultArm := preload("res://Player/BaseParts/Attachments/BaseArm.tscn")
var LeftArmAnimator: AnimationPlayer
var RightArmAnimator: AnimationPlayer

var leftArm: Node3D
var rightArm: Node3D
var active: bool = false


#	Add/Remove Arm Scenes

func addLeftArm(newArm: Resource = defaultArm) -> void:
	if !leftArm:
		var arm = newArm.instantiate()
		arm.isEnemyPart = true
		LeftArmAnchor.add_child(arm)
		leftArm = arm
		arm.isLeftArm = true
		arm.ownerMesh = mesh
		arm.set_arms()

func addRightArm(newArm: Resource = defaultArm) -> void:
	if !rightArm:
		var arm = newArm.instantiate()
		arm.isEnemyPart = true
		RightArmAnchor.add_child(arm)
		rightArm = arm
		arm.isLeftArm = false
		arm.ownerMesh = mesh
		arm.set_arms()


func removeLeftArm() -> void:
	if !leftArm:
		return
	var worldRef:= get_tree().root.get_child(0)
	var armDrop: Node3D = load(leftArm.dropRef).instantiate()
	worldRef.add_child(armDrop)
	armDrop.global_position = leftArm.global_position
	leftArm.queue_free()

func removeRightArm() -> void:
	if !rightArm:
		return
	var worldRef:= get_tree().root.get_child(0)
	var armDrop: Node3D= load(rightArm.dropRef).instantiate()
	worldRef.add_child(armDrop)
	armDrop.global_position = rightArm.global_position
	rightArm.queue_free()


#	Arm Actions
func action(actionType: String) -> void:
	if !active:
		return
	
	if leftArm:
		leftArm.action(actionType)
	else:
		print('missing left arm')
	if rightArm:
		rightArm.action(actionType)
	else:
		print('missing right arm')


func action_stop(actionType: String) -> void:
	if !active:
		return

	if leftArm:
		leftArm.action_stop(actionType)
	else:
		print('missing left arm')
	if rightArm:
		rightArm.action_stop(actionType)
	else:
		print('missing right arm')
	active = false
