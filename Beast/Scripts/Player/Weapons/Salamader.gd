extends Node2D

@onready var player = get_parent().player
@onready var aim = get_parent().aim
@export var bullet: PackedScene

var auto = true

var ammo = 100
var shotCooldown = 0

var maxAmmo = 100
var shotPower = 200
var shotDelay = .01

var projSpeed = 300
var projLife = 1

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.is_on_floor():
		ammo = maxAmmo
	if shotCooldown > 0:
		shotCooldown -= delta

func shoot():
	if ammo > 0 and shotCooldown <= 0:
		player.velocity.x = sin(aim.rotation) * shotPower
		player.velocity.y = cos(aim.rotation) * shotPower * -1
		ammo -= 1
		shotCooldown = shotDelay
		
		var angle = aim.rotation - deg_to_rad(20) + deg_to_rad(randf_range(-4, 4) + 20)
		var b = bullet.instantiate()
		player.get_parent().add_child(b)
		b.position = player.position
		b.angle = angle
		b.speed = projSpeed
		b.lifeTime = projLife
		angle += deg_to_rad(4)
