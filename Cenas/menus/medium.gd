extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_medium_mouse_entered():
	$Sprite.position.y -= 20


func _on_medium_mouse_exited():
	$Sprite.position.y += 20


func _on_medium_pressed():
	Global.level = 2
