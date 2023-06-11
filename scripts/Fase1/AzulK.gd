extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var daddy = null

func _ready():
	print("KinematicBody lendo estado")
	var daddy = get_parent()
	print(daddy.get_player_turn())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
export (int) var speed = 400

var velocity = Vector2()

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
	velocity = velocity.normalized() * speed
	if (velocity != Vector2(0,0)):
		velocity.x *= -1
		rotation_degrees = rad2deg(velocity.angle_to(Vector2(0,1)))
		velocity.x *= -1
func _physics_process(delta):
	
	get_input()
	velocity = move_and_slide(velocity)
