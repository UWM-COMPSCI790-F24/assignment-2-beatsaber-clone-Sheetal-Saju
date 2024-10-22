extends XRController3D

var active_collider = null
var laser_on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"LineRenderer".visible = false
	$"RayCast3D".enabled = false 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if laser_on:
		var start = global_position + (-global_basis.z * 0.1)
		var end = (-global_basis.z * 10.0) + start
		
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

			if $"RayCast3D".get_collider().name == "Cube":
				print("Cube hit! Destroying cube.")
				$"RayCast3D".get_collider().queue_free()

		elif active_collider != null:
			active_collider = null

func _on_button_pressed(name: String) -> void:
	if name == "ax_button":
		laser_on = !laser_on
		
		$"LineRenderer".visible = laser_on
		$"RayCast3D".enabled = laser_on
