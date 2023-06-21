extends KinematicBody2D

const SHOT := preload("res://Cenas/Objetos/magic.tscn")

# Called when the node enters the scene tree for the first time.
var daddy = null

export (int) var speed = 50

var velocity = Vector2()
var shotDirection = Vector2.ZERO
var oldPosition = position
var newPosition = position
var expression;
var this_wizard

var focus_activate = false

func _ready():
	$HTTPA.connect("request_completed", self, "_on_HTTPRequest_request_completed")
	print("KinematicBody lendo estado")
	
	var daddy = get_parent()
	print(daddy.get_player_turn())
	this_wizard = get_parent().PLAYER_STATE.BLUE
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generete_query_string(math_expression,valor):
	var BASE_STR = "http://127.0.0.1:5000/getPoints2/"
	BASE_STR += math_expression + "/"
	print(BASE_STR)
	if valor == 1:
		BASE_STR += "100/0"
	elif valor==-1:
		BASE_STR +="0/-100"
	print(BASE_STR)
	return BASE_STR


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
			if !focus_activate:
				var x = (get_parent()).direction_shot
				var texto = (($"../LineEdit").get_text()).replace(" ","")
				var query_string = generete_query_string(texto,x)
				expression = texto
				var headers = PoolStringArray()
				headers.append("Content-Type: application/json")
				$HTTPA.request(query_string, headers, true, 0)
	

			
		velocity *= speed
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	newPosition = position
	$"../runBarPorc".reducePorcent(oldPosition.distance_to(newPosition)/100)
	oldPosition = newPosition

func kill():
	get_parent().kill(this_wizard)
	$Azul.self_modulate = Color("404040")
	$CollisionShape2DAzul.queue_free()
	z_index = -2
	
func spawn(spawnPoint : Vector2):
	position = spawnPoint
	oldPosition = position
	newPosition = position


func _on_HTTPAZUL_request_completed(result, response_code, headers, body):
	if response_code == 200:
			var response = body.get_string_from_utf8()
			#print(response)
			print(headers)
			var points = str(response).split(',')
			#var vector_array = []
			var vector_array = PoolVector2Array()
			
			for coords in points:
				var aux = coords.split("/")
				if len(aux) ==2:
					var x = (float(aux[0])/100) * 640
					var y = ((0-(float(aux[1])))/100) * 640
					var v = Vector2(x,y)
					vector_array.append(v)
			#print(vector_array)
			var booleano = (get_parent()).set_label(expression)
			if (get_parent()).direction_shot == -1:
				vector_array.invert()
			vector_array.insert(0,Vector2(0,0))
			get_parent().shot_runing = 1
		
			var shotInstance = SHOT.instance()
			shotInstance.new_curve(vector_array)
			shotInstance.z_index = -1
			shotInstance.position = $spellPoint.global_position 
			get_parent().add_child(shotInstance)
			
			#print(response['result'])
			
			#if points['status'] != 500:
			#	var response_list = points['result']
			#	for t in response_list:
			#		print(t)
			#	get_parent().shot_runing = 1
			#	var shotInstance = SHOT.instance()
			#	get_parent().add_child(shotInstance)
			#	shotInstance.z_index = -1
			#	shotInstance.position = $spellPoint.global_position 
			#shotInstance.set_diraction(shotDirection)
			
	else:
		print("An error occurred in the HTTP request.")
		($"../LineEdit").set_text("Função Invalida")


func _on_LineEdit_focus_entered():
	focus_activate = true


func _on_LineEdit_focus_exited():
	focus_activate = false
