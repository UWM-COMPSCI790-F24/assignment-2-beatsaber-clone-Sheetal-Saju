extends Node3D

var entered_area = null
var grabbed = null
#var grabbed_parent = null
var velocity = 0.0

var last_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	last_pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if grabbed != null:
		var delta_pos = global_position - last_pos
		grabbed.global_position += delta_pos
		
		velocity = delta_pos / delta
		
	last_pos = global_position


func _on_area_3d_area_entered(area: Area3D):
	entered_area = area

func _on_area_3d_area_exited(area: Area3D) -> void:
	entered_area = null
	

func _on_input_float_changed(name: String, value: float):
	if name == "grip":
		if grabbed == null and entered_area != null and value >= 0.2:			
			grabbed = entered_area.get_parent_node_3d()
			#grabbed.set_freeze_enabled(true)
			
		if grabbed != null and value < 0.2:
			#grabbed.set_freeze_enabled(false)
			grabbed.linear_velocity = velocity
			grabbed = null
			velocity = 0.0
			
