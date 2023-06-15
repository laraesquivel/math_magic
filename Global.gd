extends Node

var magicShot = Vector2.ZERO
signal hitted

func emit_hit():
	emit_signal("hitted")

func _ready():
	pass

