extends Node3D

@export var material: ShaderMaterial
@export var speed := 0.5

var t := 0.0

func _ready():
	_apply(self)

func _process(delta):
	t += delta * speed
	material.set_shader_parameter("custom_time", t)

func _apply(node):
	for child in node.get_children():
		
		if child is MeshInstance3D:
			child.material_override = material
		
		if child is CSGMesh3D:
			child.material = material
		
		_apply(child)
