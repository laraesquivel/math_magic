extends Path2D


var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	var label
	var newCurve = Curve2D.new()
	for x in range(0,1000):
		label = Label.new()
		label.set_text(".")
		label.set_position(Vector2(x,(50*sin(0.1*x))))
		add_child(label)
		#newCurve.add_point(Vector2(x,(5*sin(0.5*x))))
		newCurve.add_point(Vector2(x,(50*sin(0.1*x))))
	curve = newCurve
	
	var animation = $PathFollow2D/AnimationPlayer.get_animation("shot")
	var animationTime = curve.get_baked_length() / speed
	animation.length = animationTime 
	var track_index = animation.find_track(NodePath(".:unit_offset"))
	var keyId = animation.bezier_track_insert_key(track_index, animationTime, 1)#animation.track_insert_key(track_index, animationTime, 1.0)
