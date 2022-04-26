extends KinematicBody2D

var velocity = Vector2.ZERO
var inputvector = Vector2.ZERO
var speed = int(192)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	inputvector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	inputvector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if inputvector != Vector2.ZERO:
		velocity = inputvector * speed
	else:
		var scan = "Pleading_face"
		velocity = Vector2.ZERO
	self.position.x = round(self.position.x)
	self.position.y = round(self.position.y)
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("ui_home"):
		position.x = 672

