extends Area2D

const SPEED := 400

var velocity := Vector2.ZERO
var direction := Vector2(1,0)

func _ready():
	pass 

func set_diraction(dir : Vector2):
	direction = dir
	direction.x *= -1
	rotation_degrees = rad2deg(direction.angle_to(Vector2(1,0)))
	direction.x *= -1
		
func _physics_process(delta : float) -> void:
	velocity.x = SPEED * delta * direction.x
	velocity.y = SPEED * delta * direction.y
	translate(velocity)
