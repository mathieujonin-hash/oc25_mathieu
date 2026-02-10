extends DirectionalLight3D

var vitesse = 10.0 # Degrés par seconde

func _process(delta):
	rotation_degrees.x += vitesse * delta
	# Optionnel: Réinitialiser la rotation pour éviter des valeurs trop grandes
	if rotation_degrees.x > 360:
		rotation_degrees.x = 0
