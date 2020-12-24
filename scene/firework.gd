extends Node2D

var one_firework_scene = preload("res://scene/one_firework.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	update_timer()
func update_timer():
	var random_time = Util.rng.randf_range(0.02,0.05)
	$Timer.wait_time = random_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	update_timer()
	var fire = one_firework_scene.instance()
	var position_size = max(Util.screen_width,Util.current_height)
	var center = Vector2(position_size/2,position_size/2)
	fire.position = Util.random_vector2(position_size,position_size) - center
	add_child(fire)
