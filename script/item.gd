extends Area2D
onready var spr = $spr
var angle = 0

var itemTaken
# Export d'enum standard Godot 3

signal loot(valeur)

func start(pos):
	if spr == null:
		spr = get_node("spr")
	self.position = pos
	print("item position: " + str(self.position))
	print("item global_position: " + str(self.global_position)) # ← seul changement ici
	var r = randi() % 100
	if r >= 35:
		return false
	else:
		if r >= 0 && r < 10:
			spr.frame = 48
			itemTaken=GLOBAL.ITEMS.BOOST
		if r >= 10 && r < 20:
			spr.frame = 49
			itemTaken=GLOBAL.ITEMS.BOMB
		if r >= 20 && r < 30:
			spr.frame = 50
			itemTaken=GLOBAL.ITEMS.SPEED
		if r >= 30 && r < 35:
			spr.frame = 51
			itemTaken=GLOBAL.ITEMS.HEART
		return true
		
func _on_item_area_entered(area):
	if(area.get_parent().name=="player"):
		self.emit_signal("loot",itemTaken)
		queue_free()
	pass # Replace with function body.
