extends CharacterBody2D


@export var SPEED : float = 225.0
@export var JUMP_VELOCITY : float = -300.0
@onready var level = get_parent()
@onready var player = level.get_node("Player")
var starting_pos : Vector2
var weight_amount : int = 0
signal death
var weights
var weight
var loaded_weights : int = 3


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
		
		if Input.is_action_just_pressed("drop") and weight_amount > 0:
			var temp_weight = load("res://Weight/Weight.tscn").instantiate()
			temp_weight.name = "Weight" + str(loaded_weights)
			temp_weight.position = position
			level.add_child(temp_weight)
			loaded_weights += 1
			weight_amount -= 1
		
		move_and_slide()


func _on_area_2d_weight_touch(weight):
	if Input.is_action_just_pressed("pickup") and weight_amount < 2:
		weight.queue_free()
		weight_amount += 1
		loaded_weights -= 1
