extends CharacterBody3D
@export var gravity := 50.0
@export var speed := 8.0
@export var health := 80
@export var LegController: Node3D
@export var ArmController: Node3D
@export var basicAttackTimer: Timer
@export var healthManager : Node3D

@onready var RightArmAnchor : Marker3D = $MeshInstance3D/AnchorPoints/RightArm
@onready var LeftArmAnchor : Marker3D = $MeshInstance3D/AnchorPoints/LeftArm
@onready var RightLegAnchor : Marker3D = $MeshInstance3D/AnchorPoints/RightLeg
@onready var LeftLegAnchor : Marker3D = $MeshInstance3D/AnchorPoints/LeftLeg

@onready var mesh : MeshInstance3D = $MeshInstance3D

var angular_acceleration := 2
var isAlive : bool = true
var playerRef: CharacterBody3D
var canBasicAttack: bool = true

func attack_process() -> void:
	if canBasicAttack:
		ArmController.active = true
		ArmController.action('basic')
		canBasicAttack = false
		basicAttackTimer.start()


func check_health() -> void:
	if healthManager.value <= 0:
		print('enemy died')
		isAlive = false
#		TODO: Drop an arm
#		Update to include legs
		var arms = []
		if ArmController.leftArm:
			arms.push_back(ArmController.removeLeftArm)
		if ArmController.rightArm:
			arms.push_back(ArmController.removeRightArm)
		
		var rng = RandomNumberGenerator.new()
		
		if arms.size() > 0:
			var randomLimb = arms[rng.randi_range(0, arms.size() - 1)]
			randomLimb.call()
		owner.queue_free()
		return

func _process(delta: float) -> void:
	if !isAlive:
		return
	check_health()

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if playerRef:
		var move_direction = playerRef.global_position - self.global_position
		var distance = move_direction.distance_to(Vector3.ZERO)
		if distance > 15:
			velocity.x = move_direction.x * speed
			velocity.z = move_direction.z * speed
			attack_process()
			LegController.walk()
			mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(move_direction.x, move_direction.z), delta * angular_acceleration)
		else:
			LegController.stop()
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
			mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(move_direction.x, move_direction.z), delta * angular_acceleration)
			attack_process()

	# standing still
	else:
		LegController.stop()
		ArmController.action_stop('basic')
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		playerRef = body


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		playerRef = null


func _on_hitbox_area_entered(_area: Area3D) -> void:
#	check for bullets or players
#	TODO: Might not be needed
	pass # Replace with function body.

# Basic Attack cooldown
func _on_timer_timeout() -> void:
	canBasicAttack = true
	ArmController.active = true
	pass # Replace with function body.
