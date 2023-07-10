extends Node2D

# Load the custom images for the mouse cursor.
var arrow = load("res://Art/UI/Cursor/pointer.png")
var beam = load("res://Art/UI/Cursor/i-beam.png")


func _ready():
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW, Vector2(16, 9))

	# Changes a specific shape of the cursor (here, the I-beam shape).
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM, Vector2(5, 16))
