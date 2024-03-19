extends Node2D

var map_node

var build_mode = false
var build_valid = false
var base_health = 100
var build_location
var build_type

var wave_finished_spawning = false
var enemies_in_wave
var game_won = false
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 60
	
	#Play music
	get_node("Music").play()
	
	GameData.player_gold = 500
	get_node("UI").update_gold(0)
	map_node = get_node("Level")  ## sélectionner la carte
	for button in get_tree().get_nodes_in_group("build_buttons"):  ## pour que cela fonctionne pour toutes les tours et récupère le nom
		button.pressed.connect(initiate_build_mode.bind(button.get_name()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if build_mode:
		update_tower_preview()
	
	enemies_in_wave = get_node("Level").get_node("Enemies").get_child_count()
	
	if game_over:
		return
	
	# If this is the last wave and it's finished
	if current_wave == max_wave_number and wave_finished_spawning and enemies_in_wave == 0:
		print("You win !")
		get_node("UI").get_node("Win").set_visible(true)
		game_won = true
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		return
		
	if wave_finished_spawning and enemies_in_wave == 0:
		await get_tree().create_timer(5).timeout
		start_next_wave()

func _unhandled_input(event):
	if not build_mode:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed:
				verify_and_build()
				cancel_build_mode()
		if event.button_index == MOUSE_BUTTON_RIGHT:
			cancel_build_mode()
			

# Build functions
	
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position =  map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if is_valid_position(current_tile):
		get_node("UI").update_tower_preview(tile_position, "ad54ff99")
		build_valid = true
		build_location = tile_position
	else:
		get_node("UI").update_tower_preview(tile_position, "ff000099")
		build_valid = false
	
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()
	
func verify_and_build():
	if build_valid:
		var new_tower = load("res://Scenes/Turret/" + build_type + "_1/" + build_type + "_1.tscn").instantiate()  ## modifier avec le chemin d'acces de la tour
		new_tower.type = build_type + "_1"
		## on peut verifier les conditions de ressources ici
		var tower_cost = GameData.tower_data[new_tower.type].price
		if get_node("UI").update_gold((-1)* tower_cost) == 0:  # il y a asser d'agent  
			new_tower.position = build_location
			new_tower.built = true
			map_node.get_node("Towers").add_child(new_tower, true)
			get_tree().call_group("enemies_path", "reconfigure_path_node")
		else:
			#peut etre créer un événement pour mettre un son ou jsp
			build_mode = false
			build_valid = false

		
func is_valid_position(current_tile) -> bool:
	# Check if node is a TowerExclusion Tile
	if not map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile) == -1:
		return false
		
	if current_tile == Vector2i(1 , 5) or current_tile == Vector2i(17 , 5):
		return false
	
	var astargrid = AStarGrid2D.new()
	astargrid.size = Vector2i(18,10)
	astargrid.cell_size = Vector2i(64, 64)
	astargrid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()
	
	# Setup A* Grid to exclude the TowerExclusion tiles
	var TowerExclusion = map_node.get_node("TowerExclusion")
	for cell in TowerExclusion.get_used_cells(0):
		astargrid.set_point_solid(cell)
		
	# Exclude the towers
	for tower in map_node.get_node("Towers").get_children():
		var tower_tile = map_node.get_node("TowerExclusion").local_to_map(tower.position)
		if(tower_tile == current_tile):
			return false
			
		astargrid.set_point_solid(tower_tile)
	
	# Exclude places where the mobs are
	for mob in get_tree().get_nodes_in_group("enemies_path"):
		var mob_tile = map_node.get_node("TowerExclusion").local_to_map(mob.position)
		if(mob_tile == current_tile):
			return false
	
	# Put the hovered tile as solid, so we check if it's blocking the path or not
	astargrid.set_point_solid(current_tile)
	
	# Remove start and end cell
	astargrid.set_point_solid(Vector2i(1 , 5), false)
	astargrid.set_point_solid(Vector2i(17 , 5), false)
	
	return not astargrid.get_id_path(Vector2i(1, 5), Vector2i(17 , 5)).is_empty()

func on_base_damage(damage):
	base_health -= damage
	if base_health <= 0:
		get_node("UI").update_health_bar(base_health, base_health)
		get_node("UI").get_node("Lose").set_visible(true)
		game_over = true
		emit_signal("game_finished", false)
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	else:
		get_node("UI").update_health_bar(base_health, damage)
		



## Wave functions
var current_wave = 0
var max_wave_number = GameData.wave_data.size()

func start_next_wave():
	# If game is over
	if game_won:
		return
	
	# If there are still enemies on the map
	if enemies_in_wave > 0:
		return

	# Semaphore	
	if not wave_finished_spawning:
		return
	
		
	wave_finished_spawning = false
	print("Starting wave ", current_wave)
	current_wave += 1
	
	var wave_data = retrieve_wave_data(current_wave)
	await get_tree().create_timer(0.2).timeout
	spawn_enemies(wave_data)
	
func retrieve_wave_data(wave_index):
	var wave_data = GameData.wave_data[wave_index - 1]
	return wave_data

func spawn_enemies(wave_data):
	for enemy_data in wave_data:
		var enemies_to_spawn = enemy_data.quantity
		while enemies_to_spawn > 0:
			var new_enemy = load("res://Scenes/Enemies/" + enemy_data.enemy_type + "/" + enemy_data.enemy_type + ".tscn").instantiate()
			new_enemy.get_node("EnemyPath").set_curve(Curve2D.new())
			map_node.get_node("Enemies").add_child(new_enemy)
			await get_tree().create_timer(enemy_data.delay).timeout
			enemies_to_spawn -= 1
		await get_tree().create_timer(1).timeout
	
	wave_finished_spawning = true
		
