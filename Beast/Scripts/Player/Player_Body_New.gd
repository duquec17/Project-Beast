extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var weapons: Array[Node]
var selectedWeapon = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 981

@export var aim: Node2D


@export var bulletDisp: TextureRect
@export var percentDisp: ProgressBar


@onready var miniCam: Camera2D = $"../CanvasLayer/SubViewportContainer/SubViewport/Camera2D2"
@onready var miniMap: SubViewport = $"../CanvasLayer/SubViewportContainer/SubViewport"


var ammo = 1
var shotCooldown = 0
#Editable Values
var maxAmmo = 1
var shotPower = 400
var airControl = false
var roundRotation = false

func _ready() -> void:
	for i in $"Weapon Storage".get_children():
		weapons.append(i)
	
	miniMap.world_2d = get_tree().root.world_2d
	$"../CanvasLayer".visible = true

func _physics_process(delta):
	
	miniCam.global_position = global_position
	
	if Input.is_action_just_pressed("swapUp"):
		switchWeapon(selectedWeapon + 1)
	if Input.is_action_just_pressed("swapDown"):
		switchWeapon(selectedWeapon - 1)
	
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
	if weapons[selectedWeapon].auto:
		if Input.is_action_pressed("shoot") and ammo > 0 and shotCooldown <= 0:
			if weapons[selectedWeapon] != null:
				weapons[selectedWeapon].shoot()
	else:
		if Input.is_action_just_pressed("shoot") and ammo > 0 and shotCooldown <= 0:
			if weapons[selectedWeapon] != null:
				weapons[selectedWeapon].shoot()
			
	ammo = weapons[selectedWeapon].ammo
	move_and_slide()
	#print(ammo)
	
	$"../CanvasLayer/Control/Label".text = weapons[selectedWeapon].description
	if weapons[selectedWeapon].ammoType == 0:
		bulletDisp.size.x = 128 * ammo
		percentDisp.show_percentage = false
		percentDisp.value = 0
	else:
		bulletDisp.size.x = 0
		percentDisp.show_percentage = true
		percentDisp.value = float(ammo) / float(weapons[selectedWeapon].maxAmmo)

func findWeapons():
	weapons = $"Weapon Storage".get_children()
	print(weapons)

func switchWeapon(num):
	if num >= len(weapons):
		num = 0
	elif num < 0:
		num = len(weapons) - 1
	selectedWeapon = num

func shoot(): #Shot Impulse Direction
	velocity.x = sin(aim.rotation) * shotPower
	velocity.y = cos(aim.rotation) * shotPower * -1

func updateWeapons():
	weapons.clear()
	for i in $"Weapon Storage".get_children():
		weapons.append(i)

func _on_reload_collider_area_entered(area): #Reload
	ammo = maxAmmo
	weapons[selectedWeapon].ammo = weapons[selectedWeapon].maxAmmo
	area.queue_free()
