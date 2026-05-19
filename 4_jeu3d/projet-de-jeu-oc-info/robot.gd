extends Node3D

@onready var label = $TextHolder/Text

var x_value : float
var y_value : float
var result : float

func setup(x, y):
	x_value = x
	y_value = y
	
func _ready():
	label.text = "(" + str(x_value) + "; " + str(y_value) + ")"
