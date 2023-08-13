extends CharacterBody2D


@export var SPEED : float = 225.0
@export var JUMP_VELOCITY : float = -300.0
@onready var level = get_parent()
@onready var weight_area = level.get_node("We!ghtArea")
@onready var player = level.get_node("Player")
var starting_pos : Vector2
var weight_amount : int = 0
signal death
signal finish_weight
var weights
var weight
var place


func _ready():
	starting_pos = position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	weights = []
	for object in level.get_children():
		#print(object)
		if "Weight" in object.name:
			#print("yup, weight")
			weights.append(object)
	
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
			place = true
			for i in weights:
				weight = i
				print(weight)
				weight_area.position = weight.position
				print(weight_area)
				await weight_area.player_return
				await player.finish_weight
			if place and weight_amount < 0:
				var temp_weight = load("res://Weight/Weight.tscn").instantiate()
				temp_weight.name = "Weight"
				temp_weight.position = position
				level.add_child(temp_weight)
		weight_area.position = Vector2(-208, -134)
		move_and_slide()


func _on_weight_area_player_return(touch):
	if touch:
		weight_amount += 1
		weight.queue_free()
		weight_area.position = Vector2(-208, -134)
		place = false
	emit_signal("finish_weight")


func _on_finish_weight():
	pass # Replace with function body.
