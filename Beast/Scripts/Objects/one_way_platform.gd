extends StaticBody2D

var playerColliding = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("down") or playerColliding:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	playerColliding = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	playerColliding = false
