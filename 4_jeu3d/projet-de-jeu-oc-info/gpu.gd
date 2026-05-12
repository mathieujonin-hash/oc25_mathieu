extends Node3D

@onready var player = $Character
@onready var character = $Character
@onready var player_camera = $Character/Head/CameraFPS
@onready var hand = $Character/Head/CameraFPS/Hand

@onready var gallery_camera = $GalleryCamera
@onready var carousel = $Gallery/Carousel

var player_near_gallery = false
var in_gallery_mode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		spawn_test_card()
	if event.is_action_pressed("interact"):
		
		if player_near_gallery and not in_gallery_mode:
			enter_gallery_mode()

		elif in_gallery_mode:
			exit_gallery_mode()

func spawn_test_card():
	var card = MeshInstance3D.new()
	card.mesh = BoxMesh.new()
	
	hand.add_child(card)
	card.position = Vector3.ZERO

func enter_gallery_mode():
	
	character.can_move_camera = false
	in_gallery_mode = true

	# Caméras
	player_camera.current = false
	gallery_camera.current = true

	# Active carousel
	carousel.set_process_input(true)

	# Bloque le joueur
	character.set_process(false)
	character.set_physics_process(false)

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func exit_gallery_mode():
	
	character.can_move_camera = true
	in_gallery_mode = false

	# Caméras
	player_camera.current = true
	gallery_camera.current = false

	# Désactive carousel
	carousel.set_process_input(false)

	# Réactive joueur
	character.set_process(true)
	character.set_physics_process(true)

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_gallery_area_body_entered(body):

	if body.name == "Character":
		player_near_gallery = true


func _on_gallery_area_body_exited(body):

	if body.name == "Character":
		player_near_gallery = false
