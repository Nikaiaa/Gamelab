extends Control

func _on_jouer_pressed():
	get_tree().change_scene_to_file("res://Scene/Appart.tscn")

func _on_options_pressed():
	pass # Replace with function body.


func _on_credit_pressed():
	pass # Replace with function body.


func _on_quitter_pressed():
	get_tree().quit()
