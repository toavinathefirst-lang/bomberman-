extends KinematicBody2D



var canMove= true
onready var tw:Tween=  $tw
onready var colladerRight = $RayRight
onready var animator:AnimationPlayer = $animator
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	var vel = Vector2()
	if Input.is_action_pressed("ui_right") and !$RayRight.is_colliding() :
		vel.x+=1
		animator.play("right")
	elif Input.is_action_pressed("ui_left") and !$RayLeft.is_colliding() : 
		vel.x -=1 
		animator.play("left")
	elif Input.is_action_pressed("ui_down") and !$RayDown.is_colliding() : 
		vel.y +=  1 
		animator.play("down")
	elif Input.is_action_pressed("ui_up") and !$RayUp.is_colliding(): 
		vel.y -=  1 
		animator.play("up")
	else:
		animator.play("idle")
	movement(vel)
	
func movement(vec):
	if canMove == true :
		canMove=false
		var oldpos= position
		var newpos=Vector2(oldpos.x  + (vec.x*64),oldpos.y + (vec.y*64))
		tw.interpolate_property(self,"position",oldpos,newpos,0.4,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
		yield(tw,"tween_completed")
		canMove =  true 
