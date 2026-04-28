extends Area2D
onready var spr = $spr
var angle = 0
# Export d'enum standard Godot 3
var type
signal loot(valeur)

func start(pos):
	if spr == null:
		spr = get_node("spr")
	self.position = pos  # ← seul changement ici
	var r = randi() % 100
	if r >= 35:
		return false
	else:
		if r >= 0 && r < 10:
			spr.frame = 48
		if r >= 10 && r < 20:
			spr.frame = 49
		if r >= 20 && r < 30:
			spr.frame = 50
		if r >= 30 && r < 35:
			spr.frame = 51
		return true
func _on_item_body_entered(body):
	print("touché")
	# En Godot 3, self.emit_signal ou emit_signal fonctionnent pareil
	emit_signal("loot", type)
	queue_free()
