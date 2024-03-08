extends Node3D

var can_move
var mouse_in_zone_true
var tampon =false
signal cantMove
# Called when the node enters the scene tree for the first time.
func _ready():
	can_move = true
	print("can move de mh = ")
	print(can_move)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _input(event):
	#if event is InputEventMouseButton && mouse_in_zone_true == true :
		#if event.is_action_pressed("left_click"):
			#cantMove.connect(_on_cant_move(event))
			#print ("object cliqué")
			#_on_cant_move(event)
			#cantMove.emit()

func _on_cant_move(event):
	can_move = false 
	#print("movhandler")
	#print(can_move)
	if InputEventMouseButton and event.is_action_pressed("left_click") and tampon == true:
		can_move = true 
		tampon = false
	tampon = true
	pass # Replace with function body.
