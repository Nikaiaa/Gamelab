extends Node3D

@onready var target_object: ColorRect = $char/CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/ColorRect

var shader_loaded = false

func _ready():
	pass 

func _process(delta: float):
	if Input.is_action_pressed("ui_select"):
		print("La touche de sélection a été appuyée")
		toggle_shader()  

func toggle_shader():
	if shader_loaded:
		target_object.shader_material.shader = null
		shader_loaded = false
	else:
		target_object.shader_material.shader = load("res://Chemin/Vers/VotreShader.shader")
		shader_loaded = true
