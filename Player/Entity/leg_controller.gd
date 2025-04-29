extends Node3D

@export var LeftLegAnchor: Marker3D
@export var RightLegAnchor: Marker3D
@export var timer: Timer

var defaultLeg = preload("res://Player/BaseParts/Attachments/BaseLeg.tscn")
var LeftLegAnimator: AnimationPlayer
var RightLegAnimator: AnimationPlayer
var walking: bool
@export var jumping: bool
var attacking: bool


func addLeftLeg() -> void:
	var leg = defaultLeg.instantiate()
	LeftLegAnchor.add_child(leg)
	LeftLegAnimator = leg.animator
	LeftLegAnimator.play('Idle')


func addRightLeg() -> void:
	var leg = defaultLeg.instantiate()
	RightLegAnchor.add_child(leg)
	RightLegAnimator = leg.animator
	RightLegAnimator.play('Idle')


func walk() -> void:
	if !jumping && !attacking:
		LeftLegAnimator.play('Walk')
		if walking == false:
			timer.start()
			walking = true


func jump() -> void:
	print('jump')
	LeftLegAnimator.play('Jump')
	RightLegAnimator.play('Jump')
	walking = false
	jumping = true


func stop() -> void:
	LeftLegAnimator.play('Idle')
	RightLegAnimator.play('Idle')
	walking = false
	jumping = false
	attacking = false


func _on_timer_timeout() -> void:
	if walking:
		RightLegAnimator.play('Walk')


func attack() -> void:
	attacking = true
	LeftLegAnimator.play('Kick')
