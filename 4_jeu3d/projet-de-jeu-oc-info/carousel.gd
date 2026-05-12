extends Node3D

@export var spacing := 1.0
@export var max_angle := 85.0
@export var center_scale := 1.5
@export var side_scale := 0.85

var cards := []
var current_index := 0

func _ready():
	cards = get_children()
	update_flow(true)

func _input(event):
	if event.is_action_pressed("ui_right"):
		current_index += 1
		update_flow()

	if event.is_action_pressed("ui_left"):
		current_index -= 1
		update_flow()

func wrap_index(index):
	var size = cards.size()
	if size == 0:
		return 0
	return (index % size + size) % size

func shortest_offset(i, current):
	var size = cards.size()
	var diff = i - current
	if diff > size / 2:
		diff -= size
	if diff < -size / 2:
		diff += size
	return diff

func update_flow(instantly := false):
	var size = cards.size()
	if size == 0:
		return

	for i in range(size):
		var card = cards[i]

		var offset = shortest_offset(i, current_index)

		if abs(offset) > 1:
			card.visible = false
			continue
		else:
			card.visible = true

		var t = offset

		var x = t * spacing

		var rot_factor = t / 2.0

		var target_position = Vector3(x, 0, 0)

		var target_rotation = Vector3(0, deg_to_rad(rot_factor * max_angle), 0)

		var target_scale = Vector3.ONE * side_scale

		if offset == 0:
			target_rotation.y = 0
			target_scale = Vector3.ONE * center_scale

		if instantly:
			card.position = target_position
			card.rotation = target_rotation
			card.scale = target_scale
		else:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(card, "position", target_position, 0.25)
			tween.tween_property(card, "rotation", target_rotation, 0.25)
			tween.tween_property(card, "scale", target_scale, 0.25)
