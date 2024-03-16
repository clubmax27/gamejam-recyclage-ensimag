extends Control


func _on_jouer_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameScene.tscn")


func _on_quiter_pressed():
	get_tree().quit()
