extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 981

@export var aim: Node2D
@export var ammoDisp: TextureRect
var ammo = 2
var shotCooldown = 0
#Editable Values
var maxAmmo = 2
var shotPower = 400
var singleShot = true
var shotDelay = .25
var airControl = true
var roundRotation = false

func _physics_process(delta):

	if shotCooldown > 0: shotCooldown -= delta
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		ammo = maxAmmo

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		if is_on_floor() or (airControl and abs(velocity.x) <= 150):                      #If not on floor, move very slowly
			velocity.x = direction * SPEED     #This gives player slight air control when moving slow
		elif abs(velocity.x) <= 50:
			velocity.x = direction * SPEED / 4
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if singleShot:
		if Input.is_action_just_pressed("shoot") and ammo > 0 and shotCooldown <= 0:
			ammo -= 1
			#shoot()
			shotCooldown = shotDelay
	else:
		if Input.is_action_pressed("shoot") and ammo > 0 and shotCooldown <= 0:
			ammo -= 1
			shoot()
			shotCooldown = shotDelay

	move_and_slide()
	print(ammo)
	ammoDisp.size.x = 128 * ammo

func shoot(): #Shot Impulse Direction
	velocity.x = sin(aim.rotation) * shotPower
	velocity.y = cos(aim.rotation) * shotPower * -1


func _on_reload_collider_area_entered(area): #Reload
	ammo = maxAmmo
	area.queue_free()
