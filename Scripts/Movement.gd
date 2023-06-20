extends CharacterBody2D

@export var acceleration = 1

@export var rotationAcceleration = 1



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	HandleRotation(delta)
	HandleSpeed(delta)
	print(str(velocity) + " " + str(rotation))
	move_and_slide()

func HandleSpeed(delta):
	velocity += int(Input.is_action_pressed("up")) * acceleration * transform.x
	
func HandleRotation(delta):
	rotation += (Input.get_axis("left", "right")) * rotationAcceleration * delta
