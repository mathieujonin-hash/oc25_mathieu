extends CSGPolygon3D

func _ready():
	var points = []
	var sides = 16
	var radius = 0.1

	for i in range(sides):
		var a = TAU * i / sides
		points.append(Vector2(cos(a), sin(a)) * radius)

	polygon = points
