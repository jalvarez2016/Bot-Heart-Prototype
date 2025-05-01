extends Node3D

@export var LeftArmAnchor: Marker3D
@export var RightArmAnchor: Marker3D
@export var addPartsUI: Container
@export var removeParts: Container
@export var mesh: MeshInstance3D

var defaultArm := preload("res://Player/BaseParts/Attachments/BaseArm.tscn")
var LeftArmAnimator: AnimationPlayer
var RightArmAnimator: AnimationPlayer

var leftArm: Node3D
var rightArm: Node3D

var nearNewArm: bool = false # Check if we can equip a new arm 
var armDrop: Node3D # New arm drop in case we need to delete it
var loadedNewArm: Resource # The new Arm


func _ready() -> void:
	addPartsUI.deactivate()
	removeParts.deactivate()

func _process(_delta: float) -> void:
	check_equip()
	_check_unequip()

#	Equip/Remove Logic
func check_equip() -> void: 
	if Input.is_action_just_pressed("equip") && nearNewArm:
		addPartsUI.activate()
	elif Input.is_action_just_released("equip"):
		addPartsUI.deactivate()
		if !addPartsUI.loadedArm:
			return
		
		if addPartsUI.isAddingLeftPart:
			addLeftArm(addPartsUI.loadedArm)
		else:
			addRightArm(addPartsUI.loadedArm)
		
		armDrop.queue_free()

func _check_unequip() -> void:
	if Input.is_action_just_pressed("unequip"):
		removeParts.activate()
	elif Input.is_action_just_released("unequip"):
		removeParts.deactivate()
		if removeParts.isRemovingLeftPart:
			removeLeftArm()
		else:
			removeRightArm()


#	Add/Remove Arm Scenes
func loadNewArm(armPath: String, newArmDrop: Node3D = null) -> void:
	if newArmDrop:
		armDrop = newArmDrop
	nearNewArm = true
	addPartsUI.loadNewArm(armPath)

func unLoadNewArm() -> void:
	armDrop = null
	nearNewArm = false
	addPartsUI.unLoadNewArm()

func addLeftArm(newArm: Resource = defaultArm) -> void:
	if !leftArm:
		var arm = newArm.instantiate()
		LeftArmAnchor.add_child(arm)
		leftArm = arm
		arm.isLeftArm = true
		arm.ownerMesh = mesh
		arm.set_arms()

func addRightArm(newArm: Resource = defaultArm) -> void:
	if !rightArm:
		var arm = newArm.instantiate()
		RightArmAnchor.add_child(arm)
		rightArm = arm
		arm.isLeftArm = false
		arm.ownerMesh = mesh
		arm.set_arms()

func removeLeftArm() -> void:
	if !leftArm:
		return
	var worldRef:= get_tree().root.get_child(0)
	var armDropInstance: Node3D= load(leftArm.dropRef).instantiate()
	worldRef.add_child(armDropInstance)
	armDropInstance.global_position = leftArm.global_position
	leftArm.queue_free()

func removeRightArm() -> void:
	if !rightArm:
		return
	var worldRef:= get_tree().root.get_child(0)
	var armDropInstance: Node3D= load(rightArm.dropRef).instantiate()
	worldRef.add_child(armDropInstance)
	armDropInstance.global_position = rightArm.global_position
	rightArm.queue_free()


#	Arm Actions
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
	
