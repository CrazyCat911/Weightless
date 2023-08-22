extends CharacterBody2D


var SPEED : float = 225.0
var JUMP_VELOCITY_0 : float = -300.0
var JUMP_VELOCITY_1 : float = -250.0
var JUMP_VELOCITY_2 : float = -75.0

@onready var level = get_parent()
@onready var player = level.get_node("Player")
var starting_pos : Vector2
var weight_amount : int = 0
signal death
var weights
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
			if weight_amount == 0:
				velocity.y = JUMP_VELOCITY_0
			elif weight_amount == 1:
				velocity.y = JUMP_VELOCITY_1
			elif weight_amount == 2:
				velocity.y = JUMP_VELOCITY_2
	
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if Input.is_action_just_pressed("drop") and weight_amount > 0:
			var temp_weight = load("res://Weight/Weight.tscn").instantiate()
			temp_weight.name = "Weight" + str(loaded_weights + 1)
			temp_weight.position = position
			level.add_child(temp_weight)
			loaded_weights += 1
			weight_amount -= 1
		
		move_and_slide()


func _on_area_2d_weight_touch(weight):
	if Input.is_action_just_pressed("pickup") and weight_amount < 2:
		weight.queue_free()
		weight_amount += 1
		if velocity.y > 0:
			velocity.y = 0


func _on_endoflevel():
	if weight_amount == 2:
		$Label.text = "Well done!"
	else:
		$Label.text = "Not enough\nweight"
 
