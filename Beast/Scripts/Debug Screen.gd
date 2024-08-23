extends Control

@export var player: CharacterBody2D

var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Icon/HScrollBar/Label2.text = str($Icon/HScrollBar.value)
	$Icon/ShotPower/Label2.text = str($Icon/ShotPower.value)
	$Icon/ShotDelay/Label2.text = str($Icon/ShotDelay.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("Debug"):
		paused = !paused
		if paused:
			$Label.text = "Press G for Settings"
			$Icon.visible = true
			get_tree().paused = true
		else:
			$Label.text = "Press G to exit Settings"
			$Icon.visible = false
			get_tree().paused = false


func _on_rapid_fire_toggled(button_pressed): #Rapid fire / single shot
	player.singleShot = !player.singleShot


func _on_rounding_toggled(button_pressed): #8 / 360 switch
	player.roundRotation = !player.roundRotation


func _on_h_scroll_bar_scrolling(): #Ammo Count
	$Icon/HScrollBar/Label2.text = str($Icon/HScrollBar.value)
	player.maxAmmo = $Icon/HScrollBar.value


func _on_shot_power_scrolling():
	$Icon/ShotPower/Label2.text = str($Icon/ShotPower.value)
	player.shotPower = $Icon/ShotPower.value


func _on_shot_delay_scrolling():
	$Icon/ShotDelay/Label2.text = str($Icon/ShotDelay.value)
	player.shotDelay = $Icon/ShtDelay.value


func _on_air_control_toggled(button_pressed):
	player.airControl = !player.airControl
