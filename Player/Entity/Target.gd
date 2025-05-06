extends RayCast3D
@export var target: Node3D
@export var resetPosition: Node3D

func _process(_delta: float) -> void:
	if self.is_colliding():
		target.global_position = self.get_collision_point()
	elif target.global_position != resetPosition.global_position:
		target.global_position = resetPosition.global_position
