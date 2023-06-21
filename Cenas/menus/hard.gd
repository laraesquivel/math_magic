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


func _on_hard_mouse_entered():
	print("entrou: hard")
	$SpriteHard.position.y -= 20


func _on_hard_mouse_exited():
	print("saio: hard")
	$SpriteHard.position.y += 20


func _on_hard_pressed():
	Global.level = 3
