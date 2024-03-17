extends "res://Scenes/Turret/Turrets.gd"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if enemy_array.is_empty():
		return
	
	if not built:
		return
		
	for enemy in enemy_array:
		if enemy.dead and not enemy.looted:
			enemy.looted = true
			get_node("UI").update_gold(GameData.enemy_data[enemy.type].gold)
			print("Gained ", GameData.enemy_data[enemy.type].gold, " gold")
