extends PathFollow2D

var map_node
var current_tile

var speed = 150
var initial_position = Vector2(80, 345)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Goblin/Animation").play()
	add_to_group("enemies_path")
	set_position(initial_position)
	set_loop(false)
	map_node = get_tree().root.get_child(1).get_node("Level")
	current_tile = map_node.get_node("TowerExclusion").local_to_map(global_position)
	
	configure_path_node()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move(delta)

func move(delta):
	set_progress(progress + speed * delta)
	
func reconfigure_path_node():
	var path_array = generate_path()
	var path = get_parent().curve
	
	path.clear_points()
	set_progress(0)
	for path_tile in path_array:
		var tile_position = map_node.get_node("TowerExclusion").map_to_local(path_tile)
		path.add_point(tile_position)
	
	path.set_point_position(0, global_position)
	
func configure_path_node():
	var path_array = generate_path()
	var path = get_parent().curve
	
	path.clear_points()
	for path_tile in path_array:
		var tile_position = map_node.get_node("TowerExclusion").map_to_local(path_tile)
		path.add_point(tile_position)
		
	
	
func generate_path():
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
		astargrid.set_point_solid(tower_tile)
	
	# Remove start and end cell
	astargrid.set_point_solid(Vector2i(1 , 5), false)
	astargrid.set_point_solid(Vector2i(17 , 5), false)
	
	return astargrid.get_id_path(map_node.get_node("TowerExclusion").local_to_map(global_position), Vector2i(17 , 5))
