extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum PLAYER_STATE {
	Wait,
	Azul,
	Vermelho,
	Verde,
	Roxo
}

var player_turn = PLAYER_STATE.Wait

var data = {
	"coords":"(3,3)",
	"expression":"2x",
	"dominio_min":-3,
	"dominio_max":3
}


# Called when the node enters the scene tree for the first time.

func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_HTTPRequest_request_completed")
	
	var headers = PoolStringArray()
	headers.append("Content-Type: application/json")
	var body_str = to_json(data)
	var caminho_absoluto = ProjectSettings.globalize_path("res://")
	print(caminho_absoluto.replace("math_magic/",""))
	caminho_absoluto += "pontos.csv/"
	print(caminho_absoluto)
	
	$HTTPRequest.request("http://127.0.0.1:5000/getPoints2/x**2+4+sin(x)/3/-3", headers, true, 0)

	set_player_turn()



func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.pressed:
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_player_turn():
	if player_turn == PLAYER_STATE.Wait:
		print("Trocando estado Wait-> Azul")
		player_turn = PLAYER_STATE.Azul	
		
	elif player_turn == PLAYER_STATE.Azul:
		print("Trocando estado Azul - > Vermelho")
		player_turn = PLAYER_STATE.Vermelho
		
	elif player_turn == PLAYER_STATE.Vermelho:
		print("Trocando estado Vermelho ->Verde")
		player_turn = PLAYER_STATE.Verde
	
	elif player_turn == PLAYER_STATE.Verde:
		print("Trocando estado Verde -> Roxo")
		player_turn = PLAYER_STATE.Roxo
	else:
		print("Trocando estado Roxo ->Azul")
		player_turn = PLAYER_STATE.Azul
	
func get_player_turn():
	return player_turn

func on_timer_out():
	#Temporizador expirou
	print("temporizador expirou")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
		if response_code == 200:
			var response = body.get_string_from_utf8()
			print(response)
			print(headers)
			
		else:
			print("An error occurred in the HTTP request.")
			
	
