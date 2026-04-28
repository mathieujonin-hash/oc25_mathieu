extends MeshInstance3D

@export var path: Path3D

func _ready():
	var tube = mesh as TubeTrailMesh
	tube.curve = path.curve
