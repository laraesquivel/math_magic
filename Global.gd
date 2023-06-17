extends Node

#esse vetor indica quais magos foram selecinoado
# Blue | Green | Purple | Red
var players = [true,true,true,true]

var magicShot = Vector2.ZERO
signal wallHitted

func emit_hit():
	emit_signal("wallHitted")

func _ready():
	pass

