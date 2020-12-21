extends Node2D

var cake_scene = preload("res://scene/cake.tscn")
var current_cake
var cake_speed = 50
var cake_direction = 1

func create_cake(x = 0):
	var cake_instance = cake_scene.instance()
	current_cake = cake_instance
	cake_instance.init(Util.current_left,Util.current_right)
	current_cake.scale = Vector2(Util.scale,Util.scale)
	cake_direction = 1
	cake_instance.position = Vector2(x,Util.get_current_cake_start())
	add_child(cake_instance)
	Util.current_level+=1

# Called when the node enters the scene tree for the first time.
func _ready():
	#init base cake
	create_cake(Util.start_x)
	
	create_cake()
	#create a moving cake
	pass # Replace with function body.

func _process(delta):
	if current_cake:
		current_cake.position += Vector2(cake_speed*delta*cake_direction,0)
		if current_cake.position.x>=Util.screen_width -  Util.current_cake_width and cake_direction == 1:
			cake_direction = -1
		if current_cake.position.x<=0 and cake_direction == -1:
			cake_direction =  1
			
func split_cake():
	current_cake.split()
	
	create_cake()
	pass
			
func _input(event):
	if event.is_action_pressed("act"):
		split_cake()

