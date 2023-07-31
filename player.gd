extends CharacterBody2D


@export var SPEED : float = 225.0
@export var JUMP_VELOCITY : float = -300.0
@onready var level = get_parent()
var starting_pos : Vector2
var weight_amount : int = 0
signal death


func _ready():
	starting_pos = position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	$Label.text = str(weight_amount)
	if position.y >= 500:
		position = starting_pos
		emit_signal("death")
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
	
		# Handle Jump.
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if Input.is_action_just_pressed("intereact"):
			pass
		
		move_and_slide()
