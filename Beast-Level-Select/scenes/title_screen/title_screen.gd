extends Control

## One Any button pressed move to other buttons
func _on_any_button_pressed():
	pass # Replace with function body.

## Searches for a empty game save to start writing new content into
func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/world_select/world_select.tscn")

## Opens menu for all game saves
func _on_load_game_pressed():
	pass # Replace with function body.

## Opens configuration menu 
func _on_config_pressed():
	pass # Replace with function body.

## On press exit button
func _on_exit_pressed():
	get_tree().quit()
