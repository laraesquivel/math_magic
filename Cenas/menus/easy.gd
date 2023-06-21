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


func _on_easy_mouse_entered():
	print("entrou: easy")
	$Sprite.position.y -= 20


func _on_easy_mouse_exited():
	print("saio: easy")
	$Sprite.position.y += 20


func _on_easy_pressed():
	Global.level = 1
