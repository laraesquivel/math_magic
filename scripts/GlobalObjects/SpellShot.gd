extends Area2D

const SPEED := 400

var velocity := Vector2.ZERO
var direction := Vector2(1,0)
var colision = CollisionShape2D

func _ready():
	pass 

func set_diraction(dir : Vector2):
	direction = dir
	direction.x *= -1
	rotation_degrees = rad2deg(direction.angle_to(Vector2(1,0)))
	direction.x *= -1
		
#func _physics_process(delta : float) -> void:
#	velocity.x = SPEED * delta * direction.x
#	velocity.y = SPEED * delta * direction.y
#	translate(velocity)

func _on_SpellShot_body_entered(body : Node):
	if(body.is_in_group("walls")):
		Global.magicShot = global_position
		Global.emit_hit()
		get_parent().get_parent().queue_free()

#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free()

