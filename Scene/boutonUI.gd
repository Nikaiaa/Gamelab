extends Control
@onready var scene = $"."
@export var narra : Label

func _ready():
	var sceneBribe = get_node("root/Node3D/Bribe")
	set_process_input(true)
	#narra.visible = true
	#narra.text = sceneBribe.resource_data.resource.dialogue

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == (KEY_ESCAPE):
			scene.queue_free()
			narra.visible = false 
			
			



