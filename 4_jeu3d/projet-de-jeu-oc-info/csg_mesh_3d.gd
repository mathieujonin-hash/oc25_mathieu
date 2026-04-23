extends CSGMesh3D

@onready var material = $CSGMesh3D.get_active_material(0)
@export var speed_factor: float = 1.0

var t := 0.0

func _process(delta):
	t += delta * speed_factor
	material.set_shader_parameter("custom_time", t)
