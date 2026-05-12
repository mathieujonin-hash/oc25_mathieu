extends Node3D
var held_card = null

func _ready():
	for card in $GalleryCarousel.get_children():
		card.selected.connect(_on_card_selected)

func _on_card_selected(card):
	if held_card:
		held_card.queue_free()
	
	held_card = card.duplicate()
	$PlayerHand.add_child(held_card)
	held_card.position = Vector3(0, 0, -1)
