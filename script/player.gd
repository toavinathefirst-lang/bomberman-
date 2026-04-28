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
	if canMove == true:
		# Calcul de la destination
		var oldpos = position
		var newpos = Vector2(oldpos.x + (vec.x * 64), oldpos.y + (vec.y * 64))
		
		# --- LA CORRECTION ICI ---
		# On force le Raycast à se mettre à jour vers la destination
		# Ou plus simple : on vérifie si la destination est un mur
		if tickBomb == true:
			var b = bombe.instance()
			get_parent().add_child(b)
			b.planted(self.position)
			tickBomb = false

		# On empêche le mouvement si le Raycast détecte un mur
		# Note: Assure-toi que tes Raycasts sont assez longs (64 unités)
		# ou utilise test_move()
		if vec.x > 0 and $RayRight.is_colliding(): return
		if vec.x < 0 and $RayLeft.is_colliding(): return
		if vec.y > 0 and $RayDown.is_colliding(): return
		if vec.y < 0 and $RayUp.is_colliding(): return

		canMove = false
		tw.interpolate_property(self, "position", oldpos, newpos, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tw.start()
		yield(tw, "tween_completed")
		canMove = true


func _on_hitbox_body_entered(body):
	pass # Replace with function body.
