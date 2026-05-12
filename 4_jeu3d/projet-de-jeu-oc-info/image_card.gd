extends Node3D

@onready var mesh_instance = $CardMesh

@export var texture: Texture2D

@export var base_width := 0.5

@export var content := ""

func _ready():
	if texture != null:
		set_texture(texture)

func set_texture(t):

	texture = t

	var mat = mesh_instance.material_override
	if mat == null:
		mat = StandardMaterial3D.new()
	else:
		mat = mat.duplicate()

	mesh_instance.material_override = mat
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_texture = texture

	var quad = mesh_instance.mesh
	if quad == null:
		quad = QuadMesh.new()
	else:
		quad = quad.duplicate()

	mesh_instance.mesh = quad

	var size = texture.get_size()
	var aspect = float(size.y) / float(size.x)

	quad.size.x = base_width
	quad.size.y = base_width * aspect
	quad.orientation = QuadMesh.FACE_Z
