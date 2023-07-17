extends Node2D

var weights
signal player_pick_return(ok_status : bool, weight)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(get_children())
	weights = []
	for object in get_children():
		#print(object)
		if "Weight" in object.name:
			#print("yup, weight")
			weights.append(object)

func _on_player_pick_check():
	var found = false
	#print(weights)
	for weight in weights:
		#print("doing a 4")
		if abs($Player.position.x - weight.position.x) <= 16:
			emit_signal("player_pick_return", true, weight)
			found = true
	if not found:
		emit_signal("player_pick_return", false, null)
