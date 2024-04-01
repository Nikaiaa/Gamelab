extends Node3D

var overCube : bool = false
var animation_player : AnimationPlayer # Déclaration de la variable au niveau de la classe
var anxiete_stop : Button

func _ready():
	var char_node = $char
	animation_player = char_node.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/ColorRect/AnimationPlayer")
	anxiete_stop = char_node.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/CanvasLayer/Button")
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
			animation_player.play("Anxiety")
			animation_player.play("bouton")

func _on_button_pressed():
	print("Le bouton a été pressé !")
