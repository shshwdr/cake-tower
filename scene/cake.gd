extends Node2D

onready var cake_sprite = $cake
onready var tween = $Tween
onready var cut_cake_sprite = $cut_cake
var left =0
var right=1
func init(_left,_right):
	left = _left
	right = _right
	
	
	
func split():
	var cut_cake_left = left
	var cut_cake_right = right
	
	if position.x < Util.last_center:
		#on the left of the last cake, should cut left
		var diff = Util.last_center - position.x
		#change left
		left+=diff
		Util.current_left = left
		cut_cake_right = left
		#cake_sprite.material.set_shader_param("left",left)
	else:
		var diff = - (Util.last_center - position.x)
		right-=diff
		
		Util.current_right = right
		cut_cake_left = right
		#cake_sprite.material.set_shader_param("right",right)
		
		
	#create the part being cut and anim it
		
	cut_cake_sprite.visible = true
	update_material(cut_cake_sprite,cut_cake_left,cut_cake_right)
	tween.interpolate_property(
				cut_cake_sprite, 
				"rect_position", 
				cut_cake_sprite.rect_position,cut_cake_sprite.rect_position+Vector2(0,200),
				0.5,
				Tween.TRANS_SINE, Tween.EASE_IN)
	var target_modulate = cut_cake_sprite.modulate
	target_modulate.a = 0
	tween.interpolate_property(
				cut_cake_sprite, 
				"modulate", 
				cut_cake_sprite.modulate,target_modulate,
				2,
				Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
	#yield(tween,"tween_completed")
	#cut_cake_sprite.queue_free()
	
	
	Util.last_center = position.x
	update_material()
	
	if right - left <Util.game_end_width:
		Events.emit_signal("game_end")
		return false
	return true
	
func update_material(sprite = cake_sprite,_left = left, _right = right):
	
	sprite.material.set_shader_param("left",_left/float(Util.cake_width))
	sprite.material.set_shader_param("right",_right/float(Util.cake_width))

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_material = cake_sprite.material.duplicate()
	cake_sprite.material = new_material
	var new_material2 = cake_sprite.material.duplicate()
	cut_cake_sprite.material = new_material2
	update_material()
