extends Node2D

@onready var player = get_parent().player
@onready var aim = get_parent().aim
@export var bullet: PackedScene
@export var description: String

@export var ammoType = 0 #This will be replced by the different ammunition visuals

var auto = false

var ammo = 1
var shotCooldown = 0

var maxAmmo = 1
var shotPower = 0
var shotDelay = .25

var projSpeed = 500
var projLife = 3
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
		ammo -= 1
		shotCooldown = shotDelay
		var angle = aim.rotation

		var b = bullet.instantiate()
		player.get_parent().add_child(b)
		b.position = player.position
		b.angle = angle
		b.speed = projSpeed
		b.lifeTime = projLife
		angle += deg_to_rad(4)
