extends Node3D

@export var radius := 3.0
@export var rotation_speed := 0.5

var angle_offset := 0.0

func _process(delta):
	angle_offset += delta * rotation_speed
	
	var index := 0
	for child in get_children():
		var angle = angle_offset + index * TAU / get_child_count()
		
		child.position = Vector3(
			cos(angle) * radius,
			0,
			sin(angle) * radius
		)
		
		child.look_at(Vector3.ZERO, Vector3.UP)
		
		index += 1
