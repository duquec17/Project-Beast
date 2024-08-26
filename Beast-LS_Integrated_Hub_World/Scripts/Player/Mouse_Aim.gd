extends Node2D
var tempRot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tempRot = global_position.direction_to(get_global_mouse_position()).angle()
	if get_parent().roundRotation:
		rotation_degrees = int(rad_to_deg(tempRot + 180 - 22.5) / 45)*45
	else:
		rotation = tempRot
	rotation -= deg_to_rad(90)

