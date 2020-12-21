extends Node

var scale = 2
var screen_width = 160*scale
var start_y = 128*scale
var cake_height = 32*scale
var current_level = 0
var cake_width = 32*3*scale
var current_cake_width = cake_width

var current_left = 0
var current_right = current_cake_width

var start_x = (screen_width-current_cake_width)/2

var last_center = start_x

func get_current_cake_start():
	return start_y-current_level*cake_height
