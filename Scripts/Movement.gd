extends CharacterBody2D

@export_category("Accelerations")
@export_range(0,10) var acceleration : int = 1
@export_range(0,2) var rotationAcceleration: float = 1

var particles : CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	particles = get_node("CPUParticles2D")
	pass # Replace with function body.


func _process(delta):
	#Emits particles only if accelerating
	particles.emitting = Input.is_action_pressed("up")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	HandleRotation(delta)
	HandleSpeed()
	#print(str(velocity) + " " + str(rotation))
	move_and_slide()

func HandleSpeed():
	velocity += int(Input.is_action_pressed("up")) * acceleration * transform.x
	
func HandleRotation(delta):
	rotation += (Input.get_axis("left", "right")) * rotationAcceleration * delta
