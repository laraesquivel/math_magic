extends Label



func _ready():
	modulate = Color(0, 0, 0)
	var color
	color = Global.connect("turnOver", self, "changColor")
	pass 

func changColor():
	print("Mudando de cor")
	var newPlayerTurn = get_parent().player_turn
	if (newPlayerTurn == get_parent().PLAYER_STATE.BLUE):
		modulate = Color("002FFF")
	elif (newPlayerTurn == get_parent().PLAYER_STATE.GREEN):
		modulate = Color("26802E")
	elif (newPlayerTurn == get_parent().PLAYER_STATE.PURPLE):
		modulate = Color("452073")
	elif (newPlayerTurn == get_parent().PLAYER_STATE.RED):
		modulate = Color("26802E")
	else:
		modulate = Color("000000")
		
	pass
