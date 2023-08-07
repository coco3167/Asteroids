extends Area2D

@export_range(1,10) var speed : int = 5

@onready var screenSize : Vector2 = get_viewport_rect().size

func init(_position, _rotation):
	set_global_transform(Transform2D(_rotation, _position))

func _physics_process(_delta):
	move_local_x(speed)
	if(position.x < 0 or position.x > screenSize.x or position.y < 0 or position.y > screenSize.y):
		queue_free()

func _on_body_entered(body):
	body.explode()
	queue_free()
