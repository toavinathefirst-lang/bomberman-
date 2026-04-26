extends Node2D
onready var fond:TileMap = $fond
onready var player = preload("res://prefab/player.tscn")
onready var enemy = preload("res://prefab/enemy.tscn")
func _ready():
	spawn(10)
	pass

func spawn(nombre:int):
	randomize()
	var lst = fond.get_used_cells_by_id(1)
	for tuile in lst :
		match randi()%4:
			0:if(fond.get_cell(tuile.x+1,tuile.y) ==2):
					fond.set_cell(tuile.x+1,tuile.y,3)
			1:if(fond.get_cell(tuile.x-1,tuile.y) ==2):
					fond.set_cell(tuile.x-1,tuile.y,3)
			2:if(fond.get_cell(tuile.x,tuile.y+1) ==2):
				fond.set_cell(tuile.x,tuile.y+1,3)
			3:if(fond.get_cell(tuile.x,tuile.y-1) ==2):
				fond.set_cell(tuile.x,tuile.y-1,3)
	yield(get_tree().create_timer(0,1),"timeout")
	creation_player_and_mob(nombre)
	print(lst)
func creation_player_and_mob(nombre:int):
	var tileGrassList = fond.get_used_cells_by_id(2)
	for x in nombre+1 :
		var obj
		if x == 0:
			obj=player.instance()
		else:
			obj=enemy.instance()
		var tuile_rn=tileGrassList[randi()%tileGrassList.size()]
		var offset = fond.map_to_world(tuile_rn)
		obj.position = Vector2(offset.x+32,offset.y+32)
		add_child(obj)
