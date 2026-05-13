extends Node3D

@onready var player = $Character
@onready var character = $Character
@onready var player_camera = $Character/Head/CameraFPS
@onready var hand = $Character/Head/CameraFPS/Hand

@onready var gallery_camera = $GalleryCamera
@onready var carousel = $Gallery/Carousel
@onready var gallery_text = $GalleryText
@onready var in_gallery_text = $InGalleryText

@onready var scanner = $Scanner
@onready var result_label = $Scanner/ResultLabel

var player_near_gallery = false
var in_gallery_mode = false
var held_card = null

var player_near_scanner = false

func _input(event):
	if event.is_action_pressed("interact"):
		
		if player_near_gallery and not in_gallery_mode:
			enter_gallery_mode()

		elif in_gallery_mode:
			exit_gallery_mode()
	
	if in_gallery_mode and event.is_action_pressed("ui_accept"):
		select_current_card()

func spawn_test_card():
	var card = MeshInstance3D.new()
	card.mesh = BoxMesh.new()
	
	hand.add_child(card)
	card.position = Vector3.ZERO

func enter_gallery_mode():
	character.visible = false
	character.can_move_camera = false
	in_gallery_mode = true
	gallery_text.visible = false
	in_gallery_text.visible = true

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
	character.visible = true
	character.can_move_camera = true
	in_gallery_mode = false
	gallery_text.visible = true
	in_gallery_text.visible = false

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
		gallery_text.visible = true


func _on_gallery_area_body_exited(body):

	if body.name == "Character":
		player_near_gallery = false
		gallery_text.visible = false

func _on_scan_area_area_entered(body):
	if body.name == "Character":
		player_near_scanner = true

func _on_scan_area_area_exited(body):
	if body.name == "Character":
		player_near_scanner = false


func select_current_card():

	if held_card != null:
		held_card.queue_free()
		
	var original_card = carousel.cards[carousel.current_index]

	var copy_card = original_card.duplicate()

	hand.add_child(copy_card)
	
	held_card = copy_card

	copy_card.visible = true
	copy_card.position = Vector3(0, 0, 0)
	copy_card.rotation_degrees = Vector3(0, -30, 0)
	copy_card.scale = Vector3.ONE * 1.5

func place_card_in_scanner(event):

	if held_card == null:
		return
	
	if event.is_action_pressed("interact"):
		held_card.get_parent().remove_child(held_card)

		scanner.add_child(held_card)

		held_card.position = Vector3.ZERO
		held_card.rotation_degrees = Vector3.ZERO
		held_card.scale = Vector3.ONE

		scan_card()

func scan_card():

	if held_card == null:
		return
	else:
		for i in randi_range(2, 5):
			result_label.text = "Scanning."
			await get_tree().create_timer(0.3).timeout
			result_label.text = "Scanning.."
			await get_tree().create_timer(0.3).timeout
			result_label.text = "Scanning..."
			await get_tree().create_timer(0.3).timeout

		await get_tree().create_timer(2.0).timeout

		result_label.text = held_card.content
