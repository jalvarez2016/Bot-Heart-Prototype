extends Node3D

@export var health: int
@export var leftArmAnimator: AnimationPlayer
@export var rightArmAnimator: AnimationPlayer
@export var gunControllers: Array[Node3D]
@export var isGun: bool
@export var isSheild: bool
@export var isLeftArm: bool
@export var leftArmMesh: Node3D
@export var rightArmMesh: Node3D
@export var dropRef: String

var actionType = {
	'MAIN': 'main',
	'SECONDARY': 'secondary',
	'SPECIAL': 'special'
}

func _ready() -> void:
	leftArmAnimator.play('Arm Idle')
	rightArmAnimator.play('Arm Idle')


func set_arms() -> void:
	if isLeftArm:
		leftArmMesh.visible = true
		leftArmMesh.weapon_controller.toggle_active()
	else:
		rightArmMesh.visible = true
		rightArmMesh.weapon_controller.toggle_active()


func action(attackType: String = actionType.MAIN ):
	if isGun:
		gunControllers.map(func(controller): controller.shoot())
	if isSheild:
		pass

func action_stop(attackType: String = actionType.MAIN ):
	if isGun:
		gunControllers.map(func(controller): controller.stop_shooting())
	if isSheild:
		pass
