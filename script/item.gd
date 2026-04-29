extends Area2D
onready var spr = $spr
var angle = 0
enum TypeItem{fire=0 ,bombe=1,speed=3,heart=4}
var itemTaken:int
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
			itemTaken=TypeItem.fire
		if r >= 10 && r < 20:
			spr.frame = 49
			itemTaken=TypeItem.bombe
		if r >= 20 && r < 30:
			spr.frame = 50
			itemTaken=TypeItem.speed
		if r >= 30 && r < 35:
			spr.frame = 51
			itemTaken=TypeItem.heart
		return true


func _on_item_area_entered(area):
	if(area.get_parent().name=="player"):
		self.emit_signal("loot",itemTaken)
		queue_free()
	pass # Replace with function body.
