extends PathFollow2D

var map_node
var current_tile

var type = "Goblin"
var speed = GameData.enemy_data[type].speed
var hp = GameData.enemy_data[type].hp

var initial_position = Vector2(80, 345)
var dead = false
var looted = false
var did_damage = false

@onready var health_bar = get_node("HealthBar")
@onready var animation = get_node("Goblin/Animation")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Configuration of health bar
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_top_level(true)
	
	
	animation.play("Walk")
	add_to_group("enemies_path")
	set_position(initial_position)
	set_loop(false)
	map_node = get_tree().root.get_child(1).get_node("Level")
	current_tile = map_node.get_node("TowerExclusion").local_to_map(global_position)
	
	configure_path_node()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if progress_ratio >= 1.0 && not did_damage:
		did_damage = true
		get_tree().root.get_child(1).on_base_damage(GameData.enemy_data[type].damage)
		on_destroy()
	if not dead:
		move(delta)

func move(delta):
	set_progress(progress + speed * delta)
	health_bar.set_position(position - Vector2(10, 19))
	
	
	
	
func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
	
func on_destroy():
	dead = true
	animation.play("Death")
	
	
	
func _on_animation_animation_finished():
	if dead:
		self.get_parent().get_parent().queue_free()

	
	
	
	
# Pathfinding functions
func reconfigure_path_node():
	var path_array = generate_path()
	var path = get_parent().curve
	print(path)
	
	path.clear_points()
	set_progress(0)
	for path_tile in path_array:
		var tile_position = map_node.get_node("TowerExclusion").map_to_local(path_tile)
		path.add_point(tile_position)
	
	path.set_point_position(0, position)
	
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

