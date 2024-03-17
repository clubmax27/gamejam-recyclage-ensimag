extends Control
var  info_is_pressed = true

func _ready():
	get_node("Music").play()
	get_node("MarginContainer/HBoxContainer/ColorRect").set_color(Color(0,0,0,0))
	get_node("MarginContainer/HBoxContainer/ColorRect/text").set_visible_characters(0)

func _on_jouer_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameScene.tscn")


func _on_quiter_pressed():
	get_tree().quit()


func _on_info_pressed():
	if not info_is_pressed:
		get_node("MarginContainer/HBoxContainer/ColorRect/text").set_visible_characters(0)
		get_node("MarginContainer/HBoxContainer/ColorRect").set_color(Color(0,0,0,0))
		
	else:
		get_node("MarginContainer/HBoxContainer/ColorRect/text").set_visible_characters(-1)
		get_node("MarginContainer/HBoxContainer/ColorRect").set_color(Color(0,0,0,0.55))
		
	info_is_pressed = not info_is_pressed
