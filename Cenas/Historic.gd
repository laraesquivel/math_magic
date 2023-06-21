extends VBoxContainer


var histFX
var histEXP


# Called when the node enters the scene tree for the first time.
func _ready():
	histFX = [$"1/f(x)",$"2/f(x)",$"3/f(x)",$"4/f(x)",$"5/f(x)",$"6/f(x)",$"7/f(x)",$"8/f(x)",$"9/f(x)",$"10/f(x)",$"11/f(x)"]
	histEXP = [$"1/funcao",$"2/funcao",$"3/funcao",$"4/funcao",$"5/funcao",$"6/funcao",$"7/funcao",$"8/funcao",$"9/funcao",$"10/funcao",$"11/funcao"]

func add(color, expre):
	for i in range(10):
		histFX[i].set_text(histFX[i+1].text)
		histEXP[i].set_text(histEXP[i+1].text)
		histFX[i].modulate = histFX[i+1].modulate
		
	$"11/f(x)".set_text("F(x) = ")
	$"11/f(x)".modulate = color
	$"11/funcao".set_text(expre)
	
