extends KinematicBody2D



var canMove:bool= true
var dirXY:Vector2=Vector2()
var list:Array=[]
var oldDir = Vector2()
onready var tw:Tween=  $tw
onready var colladerDown:RayCast2D = $RayDown
onready var colladerRight:RayCast2D = $RayRight
onready var colladerLeft:RayCast2D = $RayLeft
onready var colladerUp:RayCast2D = $RayUp
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
	movement()
	
func movement():
	if canMove == true :
		if (list.size()>0):list.clear()
		if (!colladerRight.is_colliding()):
			list.append(Vector2(1,0))
		if (!colladerLeft.is_colliding()):
			list.append(Vector2(-1,0))
		if (!colladerDown.is_colliding()):
			list.append(Vector2(0,1))
		if (!colladerUp.is_colliding()):
			list.append(Vector2(0,-1))
		if list.size()>1:
			if(list.has(oldDir)):
				list.remove(list.find(oldDir))
		if list.size()>0:	
			dirXY = list[randi()%list.size()]
			oldDir=dirXY*-1
		canMove=false
		var oldpos= position
		var newpos=Vector2(oldpos.x  + (dirXY.x*64),oldpos.y + (dirXY.y*64))
		tw.interpolate_property(self,"position",oldpos,newpos,0.6,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
		yield(tw,"tween_completed")
		canMove =  true 

func _on_hitbox_body_entered(body):
	queue_free()
	pass # Replace with function body.
