extends Node2D


@onready var timer : Timer = get_node("Timer")

var BigAsteroid = preload("res://Nodes/Asteroids/big_asteroid.tscn")
var MediumAsteroid = preload("res://Nodes/Asteroids/medium_asteroid.tscn")
var SmallAsteroid = preload("res://Nodes/Asteroids/small_asteroid.tscn")

var difficulty : int
var score : int = 0
var configFile = ConfigFile.new()

func _ready():
	randomize()
	
	configFile.load("res://config.cfg")
	difficulty = configFile.get_value("Global", "Difficulty")
	
	timer.wait_time = [2, 5, 10][difficulty]
	timer.start()
	
	$"../Player".body_entered.connect(_on_asteroid_body_entered)
	
func asteroidCreation(asteroid : PackedScene, _position : Vector2 = Vector2.ZERO):
	var newAsteroid : Asteroid = asteroid.instantiate()
	newAsteroid.tree_exiting.connect(_on_asteroid_destroyed.bind(newAsteroid))
	newAsteroid.position = _position
	add_child.call_deferred(newAsteroid)
	
	
func _on_asteroid_body_entered(body):
	if(body is Asteroid and not (body as Asteroid).exploded):
		#Save score and high score
		configFile.set_value("Global", "Score", score)
		if(configFile.get_value("Global", "High Score") < score):
			configFile.set_value("Global", "High Score", score)
		configFile.save("res://config.cfg")
		
		get_tree().change_scene_to_file("res://Nodes/Main Scenes/end_scene.tscn")
	
	
func _on_timer_timeout():
	asteroidCreation([SmallAsteroid,MediumAsteroid,BigAsteroid][randi()%3])
	
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
