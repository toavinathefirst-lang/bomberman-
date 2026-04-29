extends Node
signal lootGlobal(type,valeur)
var life=3
var bomb=2
var speed=1
var heart = 4
var boost=1
enum ITEMS {BOOST=0,BOMB=1,SPEED=2,LIFE=3,HEART=4}
func item_loot(type):
	match type:
		GLOBAL.ITEMS.BOOST:
			boost+=1
			emit_signal("lootGlobal",0,boost)
		GLOBAL.ITEMS.BOMB:
			bomb+=1
			emit_signal("lootGlobal",1,bomb)
		GLOBAL.ITEMS.HEART:
			heart+=1
			emit_signal("lootGlobal",4,heart)
			if heart == 3:
				life+=1
				heart=0
				emit_signal("lootGlobal",4,heart)
				emit_signal("lootGlobal",3,life)
