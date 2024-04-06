extends Node

signal onSelfDestroy
@onready var scene = $"."
@export var narra : Label
@export var mesh_to_snapshot : ArrayMesh
@export var snapshot_name : String


func _ready():
	#mesh_instance_3d.mesh = mesh_to_snapshot
	#await get_tree().create_timer(0.5).timeout
	#var img = sub_viewport.get_viewport().get_texture().get_image()
	#var image_path = "Bribes/bribesUI/%s.png" % snapshot_name
	#img.save_png(image_path)
	#narra.visible = true
	set_process_input(true)
	#narra.visible = true
	#narra.text = sceneBribe.resource_data.resource.dialogue


	

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == (KEY_ESCAPE):
			narra.visible = false 
			onSelfDestroy.emit()
			scene.queue_free()
			
			
			



