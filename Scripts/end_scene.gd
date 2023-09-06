extends CanvasLayer




func _on_play_again_button_down():
	get_tree().change_scene_to_file("res://Nodes/Main Scenes/main_scene.tscn")


func _on_quit_button_down():
	get_tree().quit()
