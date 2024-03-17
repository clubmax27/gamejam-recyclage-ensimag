extends PathFollow2D

var speed = 1000

func initialize(initial_point, end_point):
	set_position(initial_point)
	loop = false
	
	var path = get_parent().curve
	path.clear_points()
	path.add_point(initial_point)
	path.add_point(end_point)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(progress_ratio >= 1):
		queue_free()
	
	set_progress(progress + speed * delta)
