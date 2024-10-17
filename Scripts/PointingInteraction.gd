extends XRController3D

var active_collider = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var start = global_position + (-global_basis.z * 0.1)
	var end = (-global_basis.z * 100) + start
	
	$"LineRenderer".points[0] = start
	$"LineRenderer".points[1] = end
	
		
	$"RayCast3D".target_position = $"RayCast3D".to_local(end)
	var cur_collider = $"RayCast3D".get_collider()
	if $"RayCast3D".is_colliding():
		if active_collider == null or active_collider != cur_collider:
			active_collider = cur_collider
			$"Beeper".play()
			
		print($"RayCast3D".get_collider().get_parent().name)
		$"LineRenderer".points[1] = $"RayCast3D".get_collision_point()
	
	elif active_collider != null:
		active_collider = null
