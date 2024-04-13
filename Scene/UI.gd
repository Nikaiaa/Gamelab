extends Control

var score = 0 
@onready var label = $Bribe

func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		#print("Tu as trouvé une bribe !")
		score += 1
		#update_score_label()

func update_score_label():
	$Bribe.text = str(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
