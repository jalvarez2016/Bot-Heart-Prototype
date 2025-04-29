extends CharacterBody3D
@export var gravity := 50.0
@export var speed := 8.0
@export var jump_force := 20.0
@export var HeartHealth := 100
@export var LegController: Node3D

@onready var RightArmAnchor : Marker3D = $MeshInstance3D/AnchorPoints/RightArm
@onready var LeftArmAnchor : Marker3D = $MeshInstance3D/AnchorPoints/LeftArm
@onready var RightLegAnchor : Marker3D = $MeshInstance3D/AnchorPoints/RightLeg
@onready var LeftLegAnchor : Marker3D = $MeshInstance3D/AnchorPoints/LeftLeg


@onready var spring_arm: SpringArm3D = $Head/SpringArm3D
@onready var mesh : MeshInstance3D = $MeshInstance3D

var angular_acceleration := 7
var isAlive : bool = true
var isSprinting : bool = false
var dodging : bool = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if is_on_floor() && LegController.jumping:
		print('stop jumping')
		LegController.stop()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		LegController.jump()
		velocity.y = jump_force
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var move_direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move_direction = move_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	
	if move_direction:
		# sprinting
		if Input.is_action_pressed("sprint"):
			LegController.walk()
			isSprinting = true
			velocity.x = move_direction.x * speed * 1.8
			velocity.z = move_direction.z * speed * 1.8
			
		# walking
		else:
			LegController.walk()
			isSprinting = false
			velocity.x = move_direction.x * speed
			velocity.z = move_direction.z * speed
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(move_direction.x, move_direction.z), delta * angular_acceleration)
		
	# standing still
	else:
		if !LegController.jumping:
			LegController.stop()
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
