extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Configura_pressed():
	get_tree().change_scene("res://Cenas/menus/config.tscn")


func _on_Configura_mouse_entered():
	icon_align = Button.ALIGN_LEFT


func _on_Configura_mouse_exited():
	icon_align = Button.ALIGN_RIGHT
