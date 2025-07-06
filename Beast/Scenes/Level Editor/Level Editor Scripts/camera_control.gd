extends Camera2D

@export var level: Node2D

var prevMousePos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Editor_Z_In"):
		zoom += Vector2(.1, .1)
	if Input.is_action_just_pressed("Editor_Z_Out"):
		zoom -= Vector2(.1, .1)
		
	if Input.is_action_pressed("Editor_Pan"):
		level.position += get_global_mouse_position() - prevMousePos
	prevMousePos = get_global_mouse_position()
	
	if Input.is_action_pressed("Editor_Place"):
		$"../Level/Ground".set_cell(((get_local_mouse_position() - level.position) / 16) - Vector2(1, 1), 0, Vector2(1, 1))
	if Input.is_action_pressed("Editor_Delete"):
		$"../Level/Ground".set_cell(((get_local_mouse_position() - level.position) / 16) - Vector2(1, 1), -1, Vector2(1, 1))
