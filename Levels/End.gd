extends Area2D
signal endoflevel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlaps = get_overlapping_bodies()
	
	for i in overlaps:
		if i.name == "Player":
			emit_signal("endoflevel")
