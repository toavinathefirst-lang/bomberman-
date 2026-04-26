extends Area2D

var angle = 0
# Export d'enum standard Godot 3
enum type_item {RUBIS, COEUR, CLE, BOMBE}
export(type_item) var item_type

signal loot(valeur)

func start(pos, type):
	self.position = pos
	item_type = type
	
	# PAUSE : On attend que le noeud soit dans l'arbre (ready) 
	# pour éviter l'erreur "null instance" sur $spr
	if not is_inside_tree():
		yield(self, "ready")
	
	# Initialisation de la couleur selon le type
	match item_type:
		type_item.RUBIS:
			$spr.modulate = Color(0, 1, 0)
		type_item.COEUR:
			$spr.modulate = Color(1, 0, 0)
		type_item.CLE:
			$spr.modulate = Color(0, 0, 1)
		type_item.BOMBE:
			$spr.modulate = Color(0, 0, 0)

func _on_item_body_entered(body):
	print("touché")
	# En Godot 3, self.emit_signal ou emit_signal fonctionnent pareil
	emit_signal("loot", item_type)
	queue_free()
