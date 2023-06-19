extends Area2D

const SPEED := 500

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
	if (body.is_in_group("wizard")):
		if (body.get_parent().player_turn != body.this_wizard):
			body.kill()
			get_parent().get_parent().get_parent().set_player_turn()
			get_parent().get_parent().queue_free()
			get_parent().get_parent().get_parent().shot_runing = 0
	if (body.is_in_group("walls")):
		Global.magicShot = global_position
		Global.emit_hit()
		get_parent().get_parent().get_parent().set_player_turn()
		get_parent().get_parent().queue_free()
		get_parent().get_parent().get_parent().shot_runing = 0

#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free()

