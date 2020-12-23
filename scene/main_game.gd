extends Node2D

onready var camera = $Camera2D

var cake_scene = preload("res://scene/cake.tscn")
var current_cake
var cake_speed = 150
var cake_speed_max = 200
var cake_direction = 1
var cake_levels = [1,20]
var speed_range = [160,400]
onready var UI = $UI

var cakes = []
var repeat_time = 2
var current_repeat_time = 0
var current_cake_type = 0

func load_cakes():
	var sound_directory = Directory.new()
	sound_directory .open("res://art/cakes/")
	sound_directory.list_dir_begin(true)

	var sound = sound_directory.get_next()
	while sound != "" :
		if not "import" in sound:
			cakes.append(load("res://art/cakes/" + sound))
		sound = sound_directory.get_next()

func get_cake_texture():
	var res = cakes[current_cake_type]
	current_repeat_time+=1
	if current_repeat_time>=repeat_time:
		current_repeat_time = 0
		current_cake_type+=1
		if current_cake_type>=cakes.size():
			current_cake_type = 0
	return res

func create_cake(x = 0):
	
	
	
	var cake_instance = cake_scene.instance()
	cake_instance.update_texture(get_cake_texture())
	current_cake = cake_instance
	cake_instance.init(Util.current_left,Util.current_right)
	current_cake.scale = Vector2(Util.cake_scale,Util.cake_scale)
	cake_direction = 1
	cake_instance.position = Vector2(x - current_cake.left,Util.get_current_cake_start())
	add_child(cake_instance)
	Util.current_level+=1
	
	cake_speed = Util.calc_difficulty_range(cake_levels,speed_range,Util.current_level)
	print(cake_speed)
	
	if current_cake.position.y<camera.position.y:
		camera.position = Vector2(camera.position.x,current_cake.position.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	load_cakes()
	
	#yield(get_tree().create_timer(1), "timeout")

	Util.init()
	#init base cake
	create_cake(Util.start_x)
	
	create_cake()
	Events.connect("game_end",self,"_on_game_end")
	#create a moving cake
	pass # Replace with function body.

func _process(delta):
	if current_cake:
		current_cake.position += Vector2(cake_speed*delta*cake_direction,0)
		if current_cake.position.x>=Util.screen_width -  current_cake.right and cake_direction == 1:
			cake_direction = -1
		if current_cake.position.x<=-current_cake.left and cake_direction == -1:
			cake_direction =  1
			
func split_cake():
	if current_cake.split():
	
		create_cake()
	pass
			
func _input(event):
	if event.is_action_pressed("act"):
		split_cake()

func _on_game_end():
	UI.visible = true
	$game_end_sound.play()
	Util.game_end = true

func _on_Button_pressed():
	Util.game_end = false
	get_tree().reload_current_scene()
