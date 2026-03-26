extends Node3D

@export var max_distance = 20.0
@export var teleport_area = Vector3(10, 0, 10) # zone possible pour apparaître
@export var fov_angle = 75.0 # champ de vision tolérance
@export var teleport_cooldown = 0.5 # limiter la fréquence des téléportations

var player_camera : Camera3D
var last_teleport_time = 0.0

func _ready():
	# récupérer dynamiquement la caméra FPS du joueur
	var level = get_tree().get_current_scene()
	var player = level.get_node("Character")
	player_camera = player.get_node("Head/CameraFPS")

func _process(delta):
	if not player_camera:
		return

	last_teleport_time += delta
	if last_teleport_time < teleport_cooldown:
		return

	# si le cube n'est pas dans le champ de vision du joueur, il peut rester
	if not is_in_camera_fov():
		last_teleport_time = 0
		teleport_randomly()

func is_in_camera_fov(pos_override : Vector3 = Vector3()) -> bool:
	# calcul de l'angle entre caméra et position du cube (ou position override)
	var pos = pos_override if pos_override else global_transform.origin
	var to_pos = (pos - player_camera.global_transform.origin)
	var distance = to_pos.length()
	if distance > max_distance:
		return false

	var dir_to_pos = to_pos.normalized()
	var cam_forward = -player_camera.global_transform.basis.z
	var angle = rad_to_deg(acos(cam_forward.dot(dir_to_pos)))
	return angle <= fov_angle

func teleport_randomly():
	var tries = 0
	var max_tries = 100
	var new_pos : Vector3

	while tries < max_tries:
		# Génère une position aléatoire
		new_pos = Vector3(
			randf_range(-teleport_area.x, teleport_area.x),
			randf_range(0, teleport_area.y),
			randf_range(-teleport_area.z, teleport_area.z)
		)

		# Ajuster pour que le cube repose sur le sol
		# half_height = la moitié de la taille de ton cube en Y
		var half_height = $CSGBox3D.size.y / 2 if $CSGBox3D.has_method("size") else 0.5
		new_pos.y += half_height

		# Vérifie que la position est hors champ de vision
		if not is_in_camera_fov(new_pos):
			break
		tries += 1

	global_transform.origin = new_pos
