extends KinematicBody2D



var canMove:bool= true
var dir:int = 0
onready var tw:Tween=  $tw
onready var colladerRight:RayCast2D = $RayRight
onready var animator:AnimationPlayer = $animator
# Called when the node enters the scene tree for the first time.
func _ready():
	match randi()%3:
		0:animator.play("orange")
		1:animator.play("purple")
		2:animator.play("blue")
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	var vel = Vector2()
	if dir==0 && !$RayRight.is_colliding() :
		vel.x+=1
		
	elif dir ==1 && !$RayLeft.is_colliding() : 
		vel.x -=1 
		
	elif dir == 2 && !$RayDown.is_colliding() : 
		vel.y +=  1 
	
	elif dir == 3 && !$RayUp.is_colliding(): 
		vel.y -=  1 

	movement(vel)
	
func movement(vec):
	if canMove == true :
		canMove=false
		var oldpos= position
		var newpos=Vector2(oldpos.x  + (vec.x*64),oldpos.y + (vec.y*64))
		tw.interpolate_property(self,"position",oldpos,newpos,0.6,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
		yield(tw,"tween_completed")
		canMove =  true 
		dir=monRandom(4)
func monRandom(number:int)->int:
	return randi()%number
	pass
	
	


func _on_hitbox_body_entered(body):
	queue_free()
	pass # Replace with function body.
