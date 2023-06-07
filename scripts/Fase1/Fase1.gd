extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_turn = 0
var game_state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.pressed:
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_player_turn(turn):
	player_turn = turn
	
func get_plater_turn():
	return player_turn
