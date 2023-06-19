extends Sprite


var porcent = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	var resetRunBar
	resetRunBar = Global.connect("turnOver", self, "reset")


func _process(delta):
	scale.x = porcent
	position.x = 1072 - 304*(1-porcent)/2


func reducePorcent(red):
	var newPorcent = porcent - red
	if (newPorcent < 0):
		porcent = 0
	else:
		porcent = newPorcent

func reset():
	porcent = 1
