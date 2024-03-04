extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5
var camera
var rotation_helper
var MOUSE_SENSITIVITY = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	#setup variables
	camera = $Rotation_Helper/Camera3D
	rotation_helper = $Rotation_Helper
	#Le pointeur de la souris disparaît de l'affochage et ne peut plus quitter l'écran ou cliquer en dehors 
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	pass # Replace with function body.

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards") #get input 
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide() #allows collisions


func _input(event):
	#si la souris bouge et qu'elle est capturée
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CONFINED_HIDDEN: 
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * -MOUSE_SENSITIVITY))#rotate la caméra en y d'abord
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))#puis en x

		#on bloque la rota verticale à 50° pour pas se dévisser la nuque
		var camera_rot = rotation_helper.rotation_degrees 
		camera_rot.x = clamp(camera_rot.x, -50, 50)
		rotation_helper.rotation_degrees = camera_rot
