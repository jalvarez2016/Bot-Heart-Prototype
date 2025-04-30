extends AspectRatioContainer
@export var leftArea: Area2D
@export var rightArea: Area2D
@export var playerCamera: SpringArm3D

var isRemovingLeftPart: bool

func activate() -> void:
	leftArea.monitoring = true
	leftArea.monitorable = true
	rightArea.monitoring = true
	rightArea.monitorable = true
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	playerCamera.active = false
	self.visible = true


func deactivate() -> void:
	leftArea.monitoring = false
	leftArea.monitorable = false
	rightArea.monitoring = false
	rightArea.monitorable = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	playerCamera.active = true
	self.visible = false


func _on_left_mouse_entered() -> void:
	isRemovingLeftPart = true

func _on_left_mouse_exited() -> void:
	isRemovingLeftPart = false

func _on_right_mouse_entered() -> void:
	isRemovingLeftPart = false

func _on_right_mouse_exited() -> void:
	isRemovingLeftPart = true
