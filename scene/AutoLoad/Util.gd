extends Node


var game_end = false



var scale = 3
var width_scale = 3
var cake_scale = 2
var screen_width = 160*width_scale
var cake_height = 32*cake_scale
var start_y = 160*scale - cake_height
var current_level = 0
var cake_width = 32*3*cake_scale
var current_cake_width = cake_width
var current_left = 0
var current_right = current_cake_width

var start_x = (screen_width-cake_width)/2

var last_center = start_x
var game_end_width = cake_width/32/3

func init():
	current_level = 0
	current_cake_width = cake_width
	current_left = 0
	
	current_right = current_cake_width
	last_center = start_x

func get_current_cake_start():
	return start_y-current_level*cake_height
