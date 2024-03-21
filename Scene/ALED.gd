extends Node3D

var overCube : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_static_body_3d_mouse_entered():
	print("Jaffar je suis décoincé")
	overCube = true


func _on_static_body_3d_mouse_exited():
	print("Jaffar je suis coincé")
	overCube = false

func _unhandled_input(event):
	if event is InputEventMouseButton && overCube:
		if event.is_action_pressed("left_click"):
			$char.activeShader(true)
			
