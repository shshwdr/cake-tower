extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	process_material = process_material.duplicate()
	process_material.hue_variation = Util.rng.randf()
	yield(get_tree().create_timer(1), "timeout")
	queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
