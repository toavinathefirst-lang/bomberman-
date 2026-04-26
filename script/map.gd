extends Node2D
onready var fond:TileMap = $fond

func _ready():
	spawn()
	pass

func spawn():
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
	print(lst)
	pass
