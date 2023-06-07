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


# Called when the node enters the scene tree for the first time.
func _ready():
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
