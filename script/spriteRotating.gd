extends Sprite

var angle = 0
export var isClockWise : bool = true

func _ready():
	if isClockWise:
		angle = 0
	else:
		angle = 360

func _process(delta):
	if isClockWise:
		angle += 1
		if angle > 359: 
			angle = 0
	else:
		angle -= 1
		if angle < 1: 
			angle = 359
	
	# Applique la rotation en degrés
	self.rotation_degrees = angle
