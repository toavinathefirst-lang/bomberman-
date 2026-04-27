extends RigidBody2D
onready var part:Particles2D = $particle
onready var timer:Timer = $timer
func planted(posi:Vector2):
	position=posi
	part.emitting = true
	
func _ready():
	pass 


func _on_timer_timeout():
	get_parent().explode(position)
	queue_free()
	pass # Replace with function body.
