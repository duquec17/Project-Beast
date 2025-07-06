extends CharacterBody2D

@export var damage = 10
@export var speed = 1
@export var lifeTime = 5
var angle = 0
var angleBasedVelocity = true
var shrink = 1
var grow = 0

var spawnPlatform = false

var platformLife = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifeTime -= delta
	platformLife -= delta
	if lifeTime <= 0:
		spawnPlatform = true
	
	if platformLife <= 0:
		queue_free()
	
	if Input.is_action_just_released("shoot"):
		spawnPlatform = true
	
	
	if spawnPlatform:
		if shrink > 0:
			shrink -= delta * 4
			grow += delta * 4
			if shrink < 0:
				shrink = 0
				grow = 1
			$Sprite2D.scale = Vector2(shrink, shrink) * .141
			$OneWayPlatform/Node2D.scale = Vector2(grow, grow)
			$OneWayPlatform.rotation = rotation * -1
			$OneWayPlatform.position.x = 0
		$hitEnemy/CollisionShape2D.disabled = true
	else:
		if angleBasedVelocity:
			rotation = angle + deg_to_rad(90)
			velocity.x = sin(angle) * speed * -1
			velocity.y = cos(angle) * speed
		move_and_slide()


func _on_detect_floor_area_entered(area: Area2D) -> void:
	spawnPlatform = true

func _on_detect_floor_body_entered(body):
	spawnPlatform = true
