extends Node2D

@export var acceleration = 1
var _speed = 0

@export var rotationAcceleration = 1
var _rotation = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	HandleSpeed()
	HandleRotation()	
	print(str(_speed) + " " + str(_rotation))

func HandleSpeed():
	_speed += acceleration * ((int)(Input.is_action_pressed("ui_up")) - (int)(Input.is_action_pressed("ui_down")))
	_speed = max(0, _speed)
	
func HandleRotation():
	_rotation += rotationAcceleration * ((int)(Input.is_action_pressed("ui_right")) - (int)(Input.is_action_pressed("ui_left")))
	#Handle overflow
	_rotation = max(-180, _rotation)
	_rotation = min(180, _rotation)
