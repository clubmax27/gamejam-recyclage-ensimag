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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
			
	
func initiate_build_mode(tower_type):
	build_type = tower_type + "T1"
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position =  map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true
		build_location = tile_position
	else:
		get_node("UI").update_tower_preview(tile_position, "adff4545")
		build_valid = false
	
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").queue_free()
	
func verify_and_build():
	if build_valid:
		## on peut verifier les conditions de ressources ici
		var new_tower = load("res://Scenes/Turret_Bow_1.tscn").instantiate()  ## modifier avec le chemin d'acces de la tour
		new_tower.position = build_location
		map_node.get_node("Towers").add_child(new_tower, true)
		
		## enlever les ressources 
		## update player ui
