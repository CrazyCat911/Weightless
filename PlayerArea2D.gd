extends Area2D
signal weight_touch(weight : RigidBody2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlappingbodies = get_overlapping_bodies()
	for i in overlappingbodies:
		if "Weight" in i.name:
			emit_signal("weight_touch", i)
