extends Area3D

var qteInput = "ui_accept"
var qteFenetre = 2.0
var qteActive = false
var qteTimer = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if qteActive: 
		qteTimer+= delta
		if qteTimer > qteFenetre:
			handleQTEResult(false) #echec
			
func startQTE():
	qteActive = true
	qteTimer = 0.0

func handleQTEResult(success):
	if success:
		print("QTE reussi")
	else:
		print("échoué")
	qteActive = false

func _input(event):
	if event.is_action_pressed(qteInput) and qteActive:
		handleQTEResult(true)
