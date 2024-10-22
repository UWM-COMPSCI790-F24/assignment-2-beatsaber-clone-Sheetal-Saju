extends WorldEnvironment

var cube = preload("res://SceneInstance/Cube.tscn")
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 1
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	
	timer.timeout.connect(_on_Timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_Timer_timeout() -> void:
	var cube_instance = cube.instantiate()
	cube_instance.set_script(load("res://Scripts/CubeLeft.gd"))
	cube_instance.get_child(0).set_collision_layer_value(9, true)
	add_child(cube_instance)
