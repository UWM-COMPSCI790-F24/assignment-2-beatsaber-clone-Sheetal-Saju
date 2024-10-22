extends Node3D

var cube_speed = 2.0
var initial_distance = 10.0
var cube_size = Vector3(1, 1, 1)
var target_position = Vector3(1.2, 1.5, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_transform.origin = Vector3(1.2, 1.5, -initial_distance)
	$"Cube".scale = cube_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = (target_position - global_transform.origin).normalized()

	global_transform.origin += direction * cube_speed * delta

	if global_transform.origin.distance_to(target_position) < 0.5:
		#print("Cube has reached the user!")
		queue_free()
