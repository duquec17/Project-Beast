extends CharacterBody2D

@export var damage = 1
@export var speed = 1
@export var lifeTime = 5
var angle = 0
var angleBasedVelocity = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifeTime -= delta
	if lifeTime <= 0:
		queue_free()
	if angleBasedVelocity:
		rotation = angle + deg_to_rad(90)
		velocity.x = sin(angle) * speed * -1
		velocity.y = cos(angle) * speed
	move_and_slide()


func _on_area_2d_area_entered(area):
	queue_free()

func _on_detect_floor_body_entered(body):
	queue_free()
