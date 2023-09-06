extends Node2D

@export_enum("Easy: 10", "Medium : 5", "Difficult : 2") var difficulty : int

@onready var timer : Timer = get_node("Timer")

var BigAsteroid = preload("res://Nodes/Asteroids/big_asteroid.tscn")
var MediumAsteroid = preload("res://Nodes/Asteroids/medium_asteroid.tscn")
var SmallAsteroid = preload("res://Nodes/Asteroids/small_asteroid.tscn")

var score : int = 0

func _ready():
	randomize()
	
	timer.wait_time = difficulty
	timer.start()
	
	$"../Player".body_entered.connect(_on_asteroid_body_entered)
	
func asteroidCreation(asteroid : PackedScene, position : Vector2 = Vector2.ZERO):
	var newAsteroid : Asteroid = asteroid.instantiate()
	newAsteroid.tree_exiting.connect(_on_asteroid_destroyed.bind(newAsteroid))
	newAsteroid.position = position
	add_child.call_deferred(newAsteroid)
	
	
func _on_asteroid_body_entered(body):
	if(body is Asteroid and not (body as Asteroid).exploded):
		get_tree().change_scene_to_file("res://Nodes/Main Scenes/end_scene.tscn")
	
	
func _on_timer_timeout():
	asteroidCreation(BigAsteroid)
	
func _on_asteroid_destroyed(asteroid : Asteroid):
	score+=1
	$"../Label".text = "Score : %s" % score
	
	match(asteroid.size):
		1:
			for loop in range(2):
				asteroidCreation(SmallAsteroid, asteroid.position)
		2:
			for loop in range(2):
				asteroidCreation(MediumAsteroid, asteroid.position)
