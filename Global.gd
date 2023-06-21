extends Node

#esse vetor indica quais magos foram selecinoado
# Blue | Green | Purple | Red
var players = [true,true,true,false]



var magicShot = Vector2.ZERO

signal wallHitted
signal turnOver

func emit_hit():
	emit_signal("wallHitted")

func emit_turnOver():
	emit_signal("turnOver")

func _ready():
	pass

