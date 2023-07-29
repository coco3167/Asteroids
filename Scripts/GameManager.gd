extends Node2D

@export_enum("Easy: 10", "Medium : 5", "Difficult : 2") var difficulty : int

@onready var timer : Timer = get_node("Timer")

var Asteroid = preload("res://Nodes/Asteroid.tscn")
var score : int = 0

func _ready():
	randomize()
	
	timer.wait_time = difficulty
	timer.start()
	
func _on_timer_timeout():
	var asteroid = Asteroid.instantiate()
	asteroid.tree_exiting.connect(_on_asteroid_destroyed)
	add_child(asteroid)
	
func _on_asteroid_destroyed():
	score+=1
	$"../Label".text = "Score : %s" % score
