extends CanvasLayer

var configFile = ConfigFile.new()

func _ready():
	configFile.load("res://config.cfg")
	$HighScore.text = $HighScore.text.substr(0,13) + str(configFile.get_value("Global", "High Score"))
	$Score.text = $Score.text.substr(0,8) + str(configFile.get_value("Global", "Score"))

func _on_play_again_button_down():
	get_tree().change_scene_to_file("res://Nodes/Main Scenes/main_scene.tscn")


func _on_quit_button_down():
	get_tree().quit()
