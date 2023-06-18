extends Sprite


func _ready():
	var visibility
	visibility = Global.connect("turnOver", self, "changVisibility")


func changVisibility():
	var parent = get_parent().get_parent()
	if (parent.player_turn == parent.PLAYER_STATE.BLUE):
		visible = true
	else: 
		visible = false
