extends KinematicBody2D

const SHOT := preload("res://Cenas/Objetos/magic.tscn")

# Called when the node enters the scene tree for the first time.
var daddy = null

export (int) var speed = 50

var velocity = Vector2()
var shotDirection = Vector2.ZERO
var oldPosition = position
var newPosition = position

var this_wizard

func _ready():
	print("KinematicBody lendo estado")
	var daddy = get_parent()
	print(daddy.get_player_turn())
	this_wizard = get_parent().PLAYER_STATE.PURPLE
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_input():
	velocity = Vector2()
	if (get_parent().player_turn == this_wizard and not(get_parent().shot_runing)):
		if ($"../runBarPorc".porcent > 0 and not($"../LineEdit".is_focus)):
			if Input.is_action_pressed("ui_right"):
				velocity.x += 1
			if Input.is_action_pressed("ui_left"):
				velocity.x -= 1
			if Input.is_action_pressed("ui_down"):
				velocity.y += 1
			if Input.is_action_pressed("ui_up"):
				velocity.y -= 1

		velocity = velocity.normalized()
		
		# Verifica se mudou a direção do personagem
		if (velocity != Vector2(0,0)):
			shotDirection = velocity
			velocity.x *= -1
			#Rotaciona o Personagem
			rotation_degrees = rad2deg(velocity.angle_to(Vector2(0,1)))
			velocity.x *= -1	
		
		#Verifica se foi solicitado o tiro
		if Input.is_action_just_pressed("shot"):
			#get_parent().set_player_turn()
			get_parent().shot_runing = 1
			var shotInstance = SHOT.instance()
			get_parent().add_child(shotInstance)
			shotInstance.z_index = -1
			shotInstance.position = $spellPoint.global_position
			#shotInstance.set_diraction(shotDirection)
			
		velocity *= speed
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	newPosition = position
	$"../runBarPorc".reducePorcent(oldPosition.distance_to(newPosition)/100)
	oldPosition = newPosition

func kill():
	get_parent().kill(this_wizard)
	$Purple.self_modulate = Color("404040")
	$CollisionShape2DAzul.queue_free()
	z_index = -2

func spawn(spawnPoint : Vector2):
	position = spawnPoint
	oldPosition = position
	newPosition = position
