extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type


# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready game scene avant node")	
	map_node = get_node("Level")  ## sélectionner la carte
	print(map_node)
	print("ready game scene")
	print(get_tree().get_nodes_in_group("build_buttons"))
	for button in get_tree().get_nodes_in_group("build_buttons"):  ## pour que cela fonctionne pour toutes les tours et récupère le nom
		print(button)
		button.pressed.connect(initiate_build_mode.bind(button.get_name()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if build_mode:
		update_tower_preview()

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode:
		print(build_mode, "unhandle cancel")
		cancel_build_mode()
	if event.is_action_released("ui_accept") and (not build_mode):
		print(build_mode, "unhandle build")		
		verify_and_build()
		cancel_build_mode()
	
func  initiate_build_mode(tower_type):
	build_type = tower_type + "T1"
	build_mode = true
	print("dans build mode")
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
	
		var new_tower = load("res://Scenes/Turret_Bow_1.tscn").instance()  ## modifier avec le chemin d'acces de la tour
		new_tower.position = build_location
		map_node.get_node("Towers").add_child(new_tower, true)
		
		## enlever les ressources 
		## update player ui
