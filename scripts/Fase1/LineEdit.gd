extends LineEdit


var is_focus = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LineEdit_focus_entered():
	is_focus = 1
	

func _on_LineEdit_focus_exited():
	is_focus = 0


func _on_LineEdit_text_entered(new_text):
	release_focus()
