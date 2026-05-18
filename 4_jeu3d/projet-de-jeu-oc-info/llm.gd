extends Node3D

@onready var player = $Character
@onready var character = $Character
@onready var player_camera = $Character/Head/CameraFPS
@onready var hand = $Character/Head/CameraFPS/Hand

@onready var gallery_camera = $GalleryCamera
@onready var carousel = $Gallery/Carousel
@onready var gallery_text = $Gallery/GalleryText
@onready var in_gallery_text = $Gallery/InGalleryText

@onready var scanner = $Scanner
@onready var result_label = $Scanner/Screen/SubViewport/UI/ResultLabel
@onready var scanner_text = $Scanner/ScannerText
@onready var scan_mesh = $Scanner/ScanMesh
@onready var viewport = $Scanner/Screen/SubViewport
@onready var screen_mesh = $Scanner/Screen/ScreenMesh
@onready var scan_material := preload("res://laser.gdshader")



var player_near_gallery = false
var in_gallery_mode = false
var held_card = null

var player_near_scanner = false
var scan_shader_material : ShaderMaterial
var scanning = false
var scan_running = false
var scanned_content = ""

func _ready():
	await get_tree().process_frame

	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

	mat.albedo_texture = viewport.get_texture()

	screen_mesh.material_override = mat
	
	scan_shader_material = ShaderMaterial.new()
	scan_shader_material.shader = scan_material

	scan_mesh.material_override = scan_shader_material

	scan_mesh.visible = false

func _input(event):
	if event.is_action_pressed("interact"):
		if scanning == false:
			if player_near_gallery and not in_gallery_mode:
				enter_gallery_mode()

			elif in_gallery_mode:
				exit_gallery_mode()
			
		if player_near_scanner and held_card != null:
			place_card_in_scanner(event)
	
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
		if scanning == true:
			gallery_text.text = "Please wait for the scan to complete"
		else:
			gallery_text.text = "Press E to interact"
		gallery_text.visible = true


func _on_gallery_area_body_exited(body):

	if body.name == "Character":
		player_near_gallery = false
		gallery_text.visible = false

func _on_scan_area_body_entered(body):
	if body.name == "Character":
		player_near_scanner = true
		if held_card != null:
			scanner_text.visible = true

func _on_scan_area_body_exited(body):
	if body.name == "Character":
		player_near_scanner = false
		scanner_text.visible = false


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
	
	if event.is_action_pressed("interact"):
		
		scanning = true
		
		for child in scanner.get_children():
			if child.name.begins_with("ImageCard"):
				child.free()
		
		held_card.get_parent().remove_child(held_card)
		

		scanner.add_child(held_card)

		held_card.position = Vector3.ZERO
		held_card.rotation_degrees = Vector3(0, 180, 0)
		held_card.scale = Vector3.ONE
		
		scanner_text.visible = false
		
		scan_card()
		



func scanning_text_loop():
	var dots = ""
	
	while scanning:
		dots += "."
		if dots.length() > 3:
			dots = ""
		
		result_label.text = "Scanning" + dots
		
		await get_tree().create_timer(0.3).timeout

func scan_card():

	if held_card == null:
		return

	if scan_running:
		return

	scan_running = true

	scanning_text_loop.call_deferred()
	await animate_scanner()

	scanning = false
	scan_running = false

	if held_card != null:
		scanned_content = held_card.content
		held_card = null

		result_label.text = scanned_content

func animate_scanner():

	var scan = scan_mesh

	scan.visible = true

	# Position de départ
	scan.position.y = -0.4

	# Active shader
	scan.material_override = scan_shader_material

	# Tween animation
	var tween = create_tween()

	tween.tween_property(
		scan,
		"position:y",
		0.4,
		4
	)

	await tween.finished

	scan.visible = false
