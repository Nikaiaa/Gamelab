extends Node3D

var instance
var can_move
var mouse_in_zone_true
@export var Fisheye: CanvasItem
signal cantMove
var collisionBribeScript = preload ("res://Script/collisionBribe.gd")
# Called when the node enters the scene tree for the first time.
signal Anxieux

func _ready():
	can_move = true
	print("can move")
	print(can_move)
	#collisionBribeScript.cantMove.connect(_on_cant_move)
	pass # Replace with function body.

#func _input(event):
	#if event is InputEventMouseButton && mouse_in_zone_true == true :
		#if event.is_action_pressed("left_click"):
			#cantMove.connect(_on_cant_move(event))
			#print ("object cliqué")
			#_on_cant_move(event)
			#cantMove.emit()
#func process():
	#if can_move == false:
		#$CharacterBody3D.movement = false

func _on_cant_move(_event):
	instance = %frag1.instance
	can_move = false 
	$Timer.wait_time = 5
	$Timer.start()
	print_debug($Timer.time_left)
	print ($Timer)
	#print("movhandler")
	#print(can_move)
	#if InputEventMouseButton and event.is_action_pressed("left_click") and tampon == true:
		#tampon=false

	
func _on_timer_timeout():
	print("timer stop")
	can_move = true
	instance.queue_free()
	pass # Replace with function body.

func activeShader(b : bool):
	Fisheye.material.set("shader_parameter/active",b)
