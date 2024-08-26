extends Area2D

@export_file("*.tscn","*.scn") var goTo

func _on_body_entered(body):
	get_tree().change_scene_to_file(goTo)
