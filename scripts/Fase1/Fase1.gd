extends Node2D

#Turnos
enum PLAYER_STATE {
	WAIT,
	BLUE,
	GREEN,
	PURPLE,
	RED
}

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
	if player_turn == PLAYER_STATE.WAIT:
		print("Trocando estado Wait-> Azul")
		player_turn = PLAYER_STATE.BLUE	
		
	elif player_turn == PLAYER_STATE.BLUE:
		print("Trocando estado Azul - > Vermelho")
		player_turn = PLAYER_STATE.RED
		
	elif player_turn == PLAYER_STATE.RED:
		print("Trocando estado Vermelho ->Verde")
		player_turn = PLAYER_STATE.GREEN
	
	elif player_turn == PLAYER_STATE.GREEN:
		print("Trocando estado Verde -> Roxo")
		player_turn = PLAYER_STATE.PURPLE
	else:
		print("Trocando estado Roxo ->Azul")
		player_turn = PLAYER_STATE.BLUE
	
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
	
func generate_sequence_turn():
	var list = Array()
	if (Global.players[0]):
		list.append(PLAYER_STATE.BLUE)
	if (Global.players[1]):
		list.append(PLAYER_STATE.GREEN)
	if (Global.players[2]):
		list.append(PLAYER_STATE.PURPLE)
	if (Global.players[3]):
		list.append(PLAYER_STATE.RED)
	print(list)
	
	pass


