extends Node2D

var type
var enemy = null
var enemy_array = []
var built = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if built:
		add_to_group("Towers")
		get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * TurretData.tower_data[type]["range"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not enemy_array.is_empty() and built:
		select_enemy()
		turn()
	else:
		enemy = null
		
func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress) ## Progress is how may pixels enemy has travelled
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]

func turn():
	get_node("Weapon").look_at(enemy.position)


func _on_range_body_entered(body):
	enemy_array.append(body.get_parent())


func _on_range_body_exited(body):
	enemy_array.erase(body.get_parent())
