extends KinematicBody2D



var canMove= true
onready var tw:Tween=  $tw
onready var colladerRight = $RayRight
onready var animator:AnimationPlayer = $animator
onready var bombe = preload("res://prefab/bombe.tscn")

var tickBomb = false
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
	if vel != Vector2(0,0) : action(vel)
	if Input.is_action_just_pressed("ui_accept"):
		tickBomb =true;
func action(vec):
	if canMove == true :
		if tickBomb ==true :
			var b=bombe.instance()
			get_parent().add_child(b)
			b.planted(self.position)
			tickBomb=false
		if(vec==Vector2(0,0)):
			return
	
		canMove=false
		var oldpos= position
		var newpos=Vector2(oldpos.x  + (vec.x*64),oldpos.y + (vec.y*64))
		tw.interpolate_property(self,"position",oldpos,newpos,0.3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
		yield(tw,"tween_completed")
		canMove =  true 


func _on_hitbox_body_entered(body):
	print("HIT: "+str(body.name))
	pass # Replace with function body.
