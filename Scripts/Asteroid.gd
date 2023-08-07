extends RigidBody2D

@export var minMax : Vector2 = Vector2(0,100)

@onready var screenSize : Vector2 = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	var _impulse = Vector2(randi_range(minMax.x, minMax.y), randi_range(minMax.x, minMax.y))
	var _position = Vector2(randi_range(minMax.x, minMax.y), randi_range(minMax.x, minMax.y))
	apply_impulse(_impulse, _position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state):
	state.transform.origin.x = wrapf(position.x, 0, screenSize.x)
	state.transform.origin.y = wrapf(position.y, 0, screenSize.y)
	
func explode():
	freeze = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	$Sprite2D.visible = false
	
	var explosion : AnimatedSprite2D = $Explosion
	explosion.visible = true
	explosion.play("default")
	
	
func _on_explosion_animation_finished():
	queue_free()
