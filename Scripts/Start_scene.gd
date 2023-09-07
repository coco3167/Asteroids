extends CanvasLayer

var config = ConfigFile.new()


func _on_button_button_down():
	config.set_value("Global", "Difficulty", $OptionButton.selected)
	config.set_value("Global", "High Score", 0)
	config.set_value("Global", "Score", 0)
	config.save("res://config.cfg")
	
	get_tree().change_scene_to_file("res://Nodes/Main Scenes/main_scene.tscn")
