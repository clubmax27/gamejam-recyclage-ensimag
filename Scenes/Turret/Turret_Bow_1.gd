extends Node2D

@onready var bow = get_node("Bow")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Towers")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bow.play()
