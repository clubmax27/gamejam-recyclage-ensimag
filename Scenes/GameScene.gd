extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type


# Called when the node enters the scene tree for the first time.
func _ready():
	map_node = get_node("Level")  ## sélectionner la carte
	for button in get_tree().get_nodes_in_group("build_buttons"):  ## pour que cela fonctionne pour toutes les tours et récupère le nom
		button.pressed.connect(initiate_build_mode.bind(button.get_name()))
	
	start_next_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if build_mode:
		update_tower_preview()

func _unhandled_input(event):
	if not build_mode:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("Left button was clicked at ", event.position)
			else:
				print("Left button was released")	
				verify_and_build()
				cancel_build_mode()
		if event.button_index == MOUSE_BUTTON_RIGHT:
			cancel_build_mode()
			

# Build functions
	
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
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
		## on peut verifier les conditions de ressources ici
		var new_tower = load("res://Scenes/Turret/Turret_Bow_1.tscn").instantiate()  ## modifier avec le chemin d'acces de la tour
		new_tower.position = build_location
		map_node.get_node("Towers").add_child(new_tower, true)
		
		## enlever les ressources 
		## update player ui
		
func is_valid_position(current_tile) -> bool:
	# Check if node is a TowerExclusion Tile
	if not map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile) == -1:
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
	
	
	# Put the hovered tile as solid, so we check if it's blocking the path or not
	astargrid.set_point_solid(current_tile)
	
	# Remove start and end cell
	astargrid.set_point_solid(Vector2i(1 , 5), false)
	astargrid.set_point_solid(Vector2i(17 , 5), false)
	
	return not astargrid.get_id_path(Vector2i(1, 5), Vector2i(17 , 5)).is_empty()



## Wave functions
var current_wave = 0
var enemies_in_wave = 0

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(0.2).timeout
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = [["Goblin", 0.7]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for enemy_data in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + enemy_data[0] + ".tscn").instantiate()
		map_node.get_node("Enemies").add_child(new_enemy, true)
		await get_tree().create_timer(enemy_data[1]).timeout
		
