extends Camera2D

var start_zoom_out = true
var origin_position

# Called when the node enters the scene tree for the first time.
func _ready():
	origin_position = position
	pass # Replace with function body.
export var PaddingPercent = 4

func CalculateBox(InScreenSize):
	#infinity for the min max formulas to work
	var MinX = INF
	var MaxX = -INF
	var MinY = INF
	var MaxY = -INF
	#The way this works is it keeps the data from the nodes with the lowest -x,-y and highest x,y
	for eachChild in get_parent().cakes_node .get_children():
		#Will only work with 2D, 3D needs transform.origin
		var pos = eachChild.position

		MinX = min(MinX,pos.x) # if pos.x is less than infinty keep it
		MaxX = max(MaxX,pos.x) # if pos.x is more than negative infinty keep it

		MinY = min(MinY,pos.y) # the next pass it compares the old kept value with the new
		MaxY = max(MaxY,pos.y) # keeping the most relavent number for that corner

	#Because Godot uses pixels we have to correct it
	var CorrectPixel =(InScreenSize /100) * PaddingPercent

	#Godot doesn't have a MinMaxRect but we can use a list
	var FourPointList = [
	MinX - CorrectPixel.y , 
	MaxX + CorrectPixel.y , 
	MinY - CorrectPixel.y , 
	MaxY + CorrectPixel.y ]
	#This will return a Rect2
	return Rect2From4PointList(FourPointList)


#Special function for making a rect2 from the list
func Rect2From4PointList(InList):
	#Formula AX+BX/2 AY+BY/2 
	var Center = Vector2( ((InList[0] + InList[1]) /2), ((InList[3] + InList[2]) /2) )
	#Formula BX-AX BY-AY 
	var Size = Vector2( (InList[1] -InList[0]), (InList[3] - InList[2]) )
	return Rect2(Center,Size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_zoom_out:
		var ScreenSize = self.get_viewport().size

		#This function will have to update every frame
		var CustomRect2 = CalculateBox(ScreenSize)

		var ZoomRatio = max(CustomRect2.size.x/ ScreenSize.x ,\
		 CustomRect2.size.y/ ScreenSize.y)

		#ZoomRatio is a scalar so we need to turn it into a vector
		zoom = Vector2(1,1) * max(ZoomRatio, 1)
		offset = CustomRect2.position

