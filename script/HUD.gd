extends CanvasLayer
onready var bombText = $ColorRect/MarginContainer/HBoxContainer/lb_bombe
onready var lifeText = $ColorRect/MarginContainer/HBoxContainer/lb_vie
onready var  boostText =$ColorRect/MarginContainer/HBoxContainer/lb_boost
func _ready():
	bombText.text=str(GLOBAL.bomb)
	lifeText.text=str(GLOBAL.life)
	boostText.text=str(GLOBAL.boost)
	GLOBAL.connect("lootGlobal",self,"refreshItem")
	pass # Replace with function body.
func refreshItem(type,value):
	match type:
		GLOBAL.ITEMS.BOMB:
			bombText.text=str(value)
		GLOBAL.ITEMS.BOOST:
			boostText.text=str(value)
		GLOBAL.ITEMS.LIFE:
			lifeText.text = str(value)
