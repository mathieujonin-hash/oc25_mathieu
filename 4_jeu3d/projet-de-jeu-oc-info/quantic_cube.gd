extends Node3D

# ------------------------
# MODES DE TELEPORTATION
# ------------------------
enum TeleportMode {
	RANDOM,
	FIXED_POINTS
}

@export var teleport_mode : TeleportMode = TeleportMode.RANDOM

# ------------------------
# PARAMETRES
# ------------------------
@export var max_distance = 20.0
@export var teleport_area = Vector3(10, 0, 10)
@export var fov_angle = 75.0
@export var teleport_cooldown = 0.5

# positions fixes (éditables dans l'inspecteur)
@export var fixed_positions : Array[Vector3] = []

# ------------------------
# VARIABLES
# ------------------------
var player_camera : Camera3D
var last_teleport_time = 0.0


# ------------------------
# LOOP
# ------------------------
func _process(delta):
	# caméra active (FPS ou 3e personne)
	player_camera = get_viewport().get_camera_3d()

	if not player_camera:
		return

	last_teleport_time += delta
	if last_teleport_time < teleport_cooldown:
		return

	# téléportation seulement si NON regardé
	if not is_in_camera_fov():
		teleport()
		last_teleport_time = 0.0


# ------------------------
# CHOIX DU MODE
# ------------------------
func teleport():
	match teleport_mode:
		TeleportMode.RANDOM:
			teleport_randomly()
		TeleportMode.FIXED_POINTS:
			teleport_to_fixed()


# ------------------------
# MODE RANDOM
# ------------------------
func teleport_randomly():
	var tries = 0
	var max_tries = 100
	var new_pos : Vector3

	
	
	while tries < max_tries:
		new_pos = Vector3(
			randf_range(-teleport_area.x, teleport_area.x),
			randf_range(-teleport_area.y, teleport_area.y),
			randf_range(-teleport_area.z, teleport_area.z)
		)

		if not is_in_camera_fov(new_pos):
			break

		tries += 1

	global_transform.origin = new_pos


# ------------------------
# MODE POSITIONS FIXES
# ------------------------
func teleport_to_fixed():
	if fixed_positions.is_empty():
		print("⚠️ Aucune position définie !")
		return

	var valid_positions = []

	for pos in fixed_positions:
		# ✔️ on respecte complètement la position donnée
		if not is_in_camera_fov(pos):
			valid_positions.append(pos)

	if valid_positions.size() > 0:
		global_transform.origin = valid_positions.pick_random()
	else:
		print("⚠️ Toutes les positions sont visibles ! fallback utilisé")
		global_transform.origin = fixed_positions.pick_random()


# ------------------------
# DETECTION CHAMP DE VISION
# ------------------------
func is_in_camera_fov(pos_override : Vector3 = Vector3()) -> bool:
	var pos : Vector3 = global_transform.origin

	if pos_override != Vector3():
		pos = pos_override

	var to_cube = pos - player_camera.global_transform.origin
	var distance = to_cube.length()

	if distance > max_distance:
		return false

	var dir_to_cube = to_cube.normalized()
	var cam_forward = -player_camera.global_transform.basis.z

	var angle = rad_to_deg(acos(cam_forward.dot(dir_to_cube)))

	return angle <= fov_angle
