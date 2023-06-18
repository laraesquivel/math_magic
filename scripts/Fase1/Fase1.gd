extends Node2D

#Turnos
enum PLAYER_STATE {
	WAIT,
	BLUE,
	GREEN,
	PURPLE,
	RED
}

var turnSequence = Array()
var player_turn = PLAYER_STATE.WAIT

#LineEdit para conexão de rede
var line_edit
# Called when the node enters the scene tree for the first time.

func _ready():
	
	$HTTPRequest.connect("request_completed", self, "_on_HTTPRequest_request_completed")
	line_edit = get_node("LineEdit")
	line_edit.connect("text_entired",self,"_on_LineEdit_text_entered")
	
	
	
	var headers = PoolStringArray()
	headers.append("Content-Type: application/json")
	
	var caminho_absoluto = ProjectSettings.globalize_path("res://")
	print(caminho_absoluto.replace("math_magic/",""))
	caminho_absoluto += "pontos.csv/"
	print(caminho_absoluto)
	
	$HTTPRequest.request("http://127.0.0.1:5000/getPoints2/x**2+4+sin(x)/3/-3", headers, true, 0)
	
	generate_sequence_turn()
	set_player_turn()



func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.pressed:
		get_tree().quit()
	if event is InputEventKey:
		var line_edit = $LineEdit  # Substitua "$LineEdit" pelo caminho correto para o nó LineEdit em sua cena
		if event.pressed and event.scancode == KEY_ENTER:
			line_edit.emit_signal("text_entered")
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_player_turn():
#	if player_turn == PLAYER_STATE.WAIT:
#		print("Trocando estado Wait-> Azul")
#		player_turn = PLAYER_STATE.BLUE	
#		
#	elif player_turn == PLAYER_STATE.BLUE:
#		print("Trocando estado Azul - > Vermelho")
#		player_turn = PLAYER_STATE.RED
#		
#	elif player_turn == PLAYER_STATE.RED:
#		print("Trocando estado Vermelho ->Verde")
#		player_turn = PLAYER_STATE.GREEN
#	
#	elif player_turn == PLAYER_STATE.GREEN:
#		print("Trocando estado Verde -> Roxo")
#		player_turn = PLAYER_STATE.PURPLE
#	else:
#		print("Trocando estado Roxo ->Azul")
#		player_turn = PLAYER_STATE.BLUE
	print("Mudando vez")
	var current_player = turnSequence.find(player_turn)
	if player_turn == PLAYER_STATE.WAIT:
		player_turn = turnSequence[0]
	elif (current_player < turnSequence.size()-1):
		player_turn = turnSequence[current_player+1]
	else:
		player_turn = turnSequence[0]
	print("vez do: ", player_turn)
	Global.emit_turnOver()
	
func get_player_turn():
	return player_turn

func on_timer_out():
	#Temporizador expirou
	print("temporizador expirou")

func generete_query_string(math_expression):
	return "http://127.0.0.1:5000/getPoints2/x**2+4+sin(x)/3/-3"
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
		if response_code == 200:
			var response = body.get_string_from_utf8()
			print(response)
			print(headers)
			
		else:
			print("An error occurred in the HTTP request.")
			
	
func _on_LineEdit_text_entered(new_text):
	var texto = (get_node("LineEdit")).get_text()
	var query_string = generete_query_string(texto)
	
#  Verifica quantos e quais magos iram jogar e att o turnSequence com uma ordem
# aleatoria de magos para essa partida
func generate_sequence_turn():
	randomize()
	var listPlayers = Array()
	var turn = Array()
	
	if (Global.players[0]):
		listPlayers.append(PLAYER_STATE.BLUE)
	if (Global.players[1]):
		listPlayers.append(PLAYER_STATE.GREEN)
	if (Global.players[2]):
		listPlayers.append(PLAYER_STATE.PURPLE)
	if (Global.players[3]):
		listPlayers.append(PLAYER_STATE.RED)
		
	for i in range(listPlayers.size()):
		turn.append(listPlayers.pop_at(randi() % listPlayers.size()))
	turnSequence = turn
	#print("a sequencia é: ",turn)
	draw_sequence()

func draw_sequence():
	var icons = [$blueWizard,$greenWizard,$purpleWizard,$redWizard]
	if (turnSequence.size() == 4):
		icons[turnSequence[0]-1].position = Vector2(918,64)
		icons[turnSequence[1]-1].position = Vector2(997,64)
		icons[turnSequence[2]-1].position = Vector2(1076,64)
		icons[turnSequence[3]-1].position = Vector2(1155,64)
		#print(4)
	elif (turnSequence.size() == 3):
		icons[turnSequence[0]-1].position = Vector2(937.75,64)
		icons[turnSequence[1]-1].position = Vector2(1036.5,64)
		icons[turnSequence[2]-1].position = Vector2(1135.25,64)
	elif (turnSequence.size() == 2):
		icons[turnSequence[0]-1].position = Vector2(971,64)
		icons[turnSequence[1]-1].position = Vector2(1102,64)
		print(2)
	else:
		print("erro")
