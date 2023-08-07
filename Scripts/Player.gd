extends RigidBody2D

@export_category("Accelerations")
@export_range(0,10) var acceleration : int = 5
@export_range(0,10) var rotationAcceleration: int = 5

var Laser = preload("res://Nodes/Player/Laser.tscn")

@onready var screenSize : Vector2 = get_viewport_rect().size

func _process(_delta):
	if(Input.is_action_just_pressed("fire")):
		var laser : Area2D = Laser.instantiate()
		laser.init(position, rotation)
		add_sibling(laser)

func _integrate_forces(state):
	HandleRotation()
	HandleSpeed()
	ScreenWarp(state)
	

func HandleRotation():
	apply_torque_impulse(Input.get_axis("left", "right") * rotationAcceleration * 5)

func HandleSpeed():
	if(Input.is_action_pressed("up")):
		apply_central_impulse(transform.x * acceleration * 5)

func ScreenWarp(state):
	state.transform.origin.x = wrapf(position.x, 0, screenSize.x)
	state.transform.origin.y = wrapf(position.y, 0, screenSize.y)
