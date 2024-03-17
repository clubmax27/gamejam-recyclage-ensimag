extends CanvasLayer

@onready var hp_bar = get_node("HUD/InfoBar/HBoxContainer/HP bar")
@onready var hp_bar_tween = hp_bar.create_tween()

func set_tower_preview(tower_type, mouse_position):
	print("res://Scenes/Turret/" + tower_type + "/" + tower_type + "_1.tscn")
	var drag_tower = load("res://Scenes/Turret/" + tower_type + "_1/" + tower_type + "_1.tscn").instantiate()  ## a modifier pour mettre le chemin

	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ad54ff3c")
	
	var range_texture = Sprite2D.new()
	range_texture.set_name("RangeIndicator")
	range_texture.position = Vector2(0, 0)
	var scaling = GameData.tower_data[tower_type + "_1"].range / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://Assets/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ad54ff3c")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture)
	control.position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)
	
func update_tower_preview(new_position, color):
	get_node("TowerPreview").position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/RangeIndicator").modulate = Color(color)


# GAME CONTROL
func _on_pause_play_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		get_parent().wave_finished_spawning = true
		get_parent().start_next_wave()
	else:
		get_tree().paused = true


func _on_speed_up_pressed():
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)

func update_health_bar(health_value, damage):
	if health_value <= damage:
		hp_bar.value = 0
		return
	hp_bar_tween.interpolate_value(health_value, damage, 0.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if health_value >= 60:
		hp_bar.set_tint_progress("4eff15") #green
	elif 60 > health_value and health_value >= 25:
		hp_bar.set_tint_progress("e1be32") #orange
	else:
		hp_bar.set_tint_progress("e11e1e") #red
	
	hp_bar.value -= damage
		
		
