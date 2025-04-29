extends Node3D

@export var health: int
@export var animator: AnimationPlayer
@export var isGun: bool
@export var gunController: Node3D
@export var isSheild: bool

var actionType = {
	'MAIN': 'main',
	'SECONDARY': 'secondary',
	'SPECIAL': 'special'
}


func action(attackType: String = actionType.MAIN ):
	if isGun:
		gunController.shoot()
	if isSheild:
		pass

func action_stop(attackType: String = actionType.MAIN ):
	if isGun:
		gunController.stop_shooting()
	if isSheild:
		pass
