extends Node

@export var robot_scene : PackedScene
@export var robots_parent : Node3D

func _ready():
	spawn_robot()

	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.timeout.connect(spawn_robot)
	timer.autostart = true
	add_child(timer)

func spawn_robot():

	var robot = robot_scene.instantiate()
	
	get_node("/root/GPU/Robots").add_child(robot)

	var x = randi_range(0, 10)
	var y = randi_range(0, 10)

	robot.setup(x, y)
