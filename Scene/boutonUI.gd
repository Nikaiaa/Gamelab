extends Node

signal onSelfDestroy
@onready var scene = $"."
@export var narra : Label

func _ready():
	narra.visible = true
	var sceneBribe = get_node("root/Node3D/Bribe")
	set_process_input(true)
	#narra.visible = true
	#narra.text = sceneBribe.resource_data.resource.dialogue

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == (KEY_ESCAPE):
			narra.visible = false 
			onSelfDestroy.emit()
			scene.queue_free()
			
			
			



