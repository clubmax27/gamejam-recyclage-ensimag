extends PathFollow2D

var map_node
var current_tile

var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	#map_node = get_parent().get_parent().get_parent()
	# current_tile = map_node.get_node("TowerExclusion").local_to_map(global_position)
	
	print("configuring")
	#configure_path_node()
	#var enemy_path = get_node("EnemyPath")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print("moving")
	move(delta)
	print(progress_ratio)

func move(delta):
	var moved_distance = speed * delta
	global_translate(global_position + Vector2(moved_distance, moved_distance))
	
func configure_path_node():
	var path_array = generate_path()
	var path = get_node("EnemyPath")
	
	for path_tile in path_array:
		print(path_tile)
		path.add_point(path_tile)
		
	
	
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
	
	return astargrid.get_id_path(current_tile, Vector2i(17 , 5))
