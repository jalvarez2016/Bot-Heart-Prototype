extends Node3D

@export var LeftLegAnchor: Marker3D
@export var RightLegAnchor: Marker3D
@export var timer: Timer

var defaultLeg = preload("res://Player/BaseParts/Attachments/BaseLeg.tscn")
var LeftLegAnimator: AnimationPlayer
var RightLegAnimator: AnimationPlayer
var walking: bool
var attacking: bool

func addLeftLeg(legType: Resource = defaultLeg) -> void:
	var leg = legType.instantiate()
	LeftLegAnchor.add_child(leg)
	LeftLegAnimator = leg.animator
	LeftLegAnimator.play('Idle')


func addRightLeg(legType: Resource = defaultLeg) -> void:
	var leg = legType.instantiate()
	RightLegAnchor.add_child(leg)
	RightLegAnimator = leg.animator
	RightLegAnimator.play('Idle')


func walk() -> void:
	if !attacking:
		LeftLegAnimator.play('Walk')
		if walking == false:
			timer.start()
			walking = true

func stop() -> void:
	LeftLegAnimator.play('Idle')
	RightLegAnimator.play('Idle')
	walking = false
	attacking = false


func _on_timer_timeout() -> void:
	if walking:
		RightLegAnimator.play('Walk')
