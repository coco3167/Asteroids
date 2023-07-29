extends RigidBody2D

@export_range(1,10) var speed : int = 5

@onready var screenSize : Vector2 = get_viewport_rect().size

func init(_position, _rotation):
	set_global_transform(Transform2D(_rotation, _position))
	apply_central_impulse(transform.x * speed * 20000)

func _physics_process(_delta):
	if(position.x < 0 or position.x > screenSize.x or position.y < 0 or position.y > screenSize.y):
		queue_free()
