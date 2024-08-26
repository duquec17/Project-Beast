extends Camera2D

@export var target: Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = position.lerp(target.position, delta * 5)
