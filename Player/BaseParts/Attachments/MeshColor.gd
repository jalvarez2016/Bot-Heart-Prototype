extends MeshInstance3D

@export var meshRef : MeshInstance3D
@export var legMain : Node3D

func _ready() -> void:
	# entity type 0 is player
	# entity type 1 is enemy
	var entityType : int = 1 if legMain.isEnemyPart else 0
	var material: ShaderMaterial = meshRef.get_surface_override_material(0).next_pass
	material.set_shader_parameter('entityType', entityType)
