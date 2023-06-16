extends Node

var magicShot = Vector2.ZERO
signal wallHitted

func emit_hit():
	emit_signal("wallHitted")

func _ready():
	pass

