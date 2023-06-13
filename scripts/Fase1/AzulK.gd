extends KinematicBody2D

const SHOT := preload("res://Cenas/Objetos/SpellShot.tscn")

# Called when the node enters the scene tree for the first time.
var daddy = null

func _ready():
	print("KinematicBody lendo estado")
	var daddy = get_parent()
	print(daddy.get_player_turn())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
export (int) var speed = 100

var velocity = Vector2()
var shotDirection = Vector2.ZERO

func get_input():
	
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized()
	
	if (velocity != Vector2(0,0)):
		shotDirection = velocity
		velocity.x *= -1
		rotation_degrees = rad2deg(velocity.angle_to(Vector2(0,1)))
		velocity.x *= -1	
	
	if Input.is_action_just_pressed("shot"):
		var shotInstance = SHOT.instance()
		get_parent().add_child(shotInstance)
		shotInstance.z_index = -1
		shotInstance.position = $spellPoint.global_position
		shotInstance.set_diraction(shotDirection)
	
	velocity *= speed
	
func _physics_process(delta):
	
	get_input()
	velocity = move_and_slide(velocity)
