extends Area2D

@export var bar: ProgressBar

var health = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	bar.value = health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	health -= area.get_parent().damage
	bar.value = health
	if health <= 0:
		queue_free()
