extends RigidBody2D

@export var damage = 1
@export var speed = 1
@export var lifeTime = 5
var angle = 0

var adjustedSpeed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if speed > 1 and not adjustedSpeed:
		linear_velocity.x = sin(angle) * speed * -1
		linear_velocity.y = cos(angle) * speed
		adjustedSpeed = true
	$Sprite2D.rotation = get_angle_to(Vector2(position.x + linear_velocity.x, position.y + linear_velocity.y))
	lifeTime -= delta
	if lifeTime <= 0:
		queue_free()
	
	


func _on_area_2d_area_entered(area):
	queue_free()

func _on_detect_floor_body_entered(body):
	queue_free()
