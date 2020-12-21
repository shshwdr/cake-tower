extends Node2D

onready var cake_sprite = $cake

onready var cut_cake_sprite = $cut_cake
var left =0
var right=1
func init(_left,_right):
	left = _left
	right = _right
	
func split():
	if position.x < Util.last_center:
		#on the left of the last cake, should cut left
		var diff = Util.last_center - position.x
		#change left
		left+=diff
		Util.current_left = left
		#cake_sprite.material.set_shader_param("left",left)
	else:
		var diff = - (Util.last_center - position.x)
		right-=diff
		
		Util.current_right = right
		#cake_sprite.material.set_shader_param("right",right)
	Util.last_center = position.x
	update_material()
	
func update_material():
	
	cake_sprite.material.set_shader_param("left",left/float(Util.cake_width))
	cake_sprite.material.set_shader_param("right",right/float(Util.cake_width))

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_material = cake_sprite.material.duplicate()
	cake_sprite.material = new_material
	update_material()
