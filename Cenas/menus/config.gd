extends Node2D

var numPlayers = 4
var selects
func _ready():
	var players = Global.players
	selects = [$BlueMage/Sprite,$GreenMage/Sprite,$PurpleMage/Sprite,$RedMage/Sprite]
	if (not(players[0])):
		$BlueMage/Sprite.self_modulate = Color("404040")
		numPlayers -= 1
	if (not(players[1])):
		$GreenMage/Sprite.self_modulate = Color("404040")
		numPlayers -= 1
	if (not(players[2])):
		$PurpleMage/Sprite.self_modulate = Color("404040")
		numPlayers -= 1
	if (not(players[3])):
		$RedMage/Sprite.self_modulate = Color("404040")
		numPlayers -= 1
	calcule_players()

func calcule_players():
	$number2.visible = false
	$number3.visible = false
	$number4.visible = false
	
	if (numPlayers == 2):
		$number2.visible = true
	if (numPlayers == 3):
		$number3.visible = true
	if (numPlayers == 4):
		$number4.visible = true

func change_player(player):
	
	if (Global.players[player] and numPlayers > 2):
		Global.players[player] = false
		selects[player].self_modulate = Color("404040")
		numPlayers -= 1
	elif (not(Global.players[player])):
		Global.players[player] = true
		selects[player].self_modulate = Color("FFFFFF")
		numPlayers += 1
	calcule_players()


func _on_BlueMage_pressed():
	change_player(0)


func _on_GreenMage_pressed():
	change_player(1)


func _on_PurpleMage_pressed():
	change_player(2)


func _on_RedMage_pressed():
	change_player(3)


func _on_Salvar_pressed():
	get_tree().change_scene("res://Menu.tscn")
