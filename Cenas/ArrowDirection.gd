extends Button


func _ready():
	pass


func _on_Button_pressed():
	$Sprite.scale.x *= -1
	get_parent().direction_shot *= -1
	release_focus()
	
