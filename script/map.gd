extends Node2D
onready var fond:TileMap = $fond
onready var player = preload("res://prefab/player.tscn")
onready var enemy = preload("res://prefab/enemy.tscn")
onready var explosion = $explosion
export(int) var force = 2
func _ready():
	spawn(10)
	pass
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
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
func explode(post:Vector2):
	var new_pos
	var tl = explosion.world_to_map(post)
	#CENTER
	explosion.set_cellv(tl,4)
	#RIGHT
	var r = 1
	while( r<=force):
		new_pos=Vector2(tl.x+r,tl.y)
		if(fond.get_cellv(new_pos) == 2): #verifie si c est de l herbe 
			explosion.set_cellv(new_pos,5)
		else:
			break
		r+=1
	explosion.set_cellv(new_pos,6)
	
	#left
	r=1
	while( r<=force):
		new_pos=Vector2(tl.x-r,tl.y)
		if(fond.get_cellv(new_pos) == 2):
			explosion.set_cellv(new_pos,5)
		else:
			break
		r+=1
	explosion.set_cellv(new_pos,3)
	
	#up 
	r=1
	while( r<=force):
		new_pos=Vector2(tl.x,tl.y - r)
		if(fond.get_cellv(new_pos) == 2):
			explosion.set_cellv(new_pos,1)
		else:
			break
		r+=1
	explosion.set_cellv(new_pos,0)
	#down
	r=1
	while( r<=force):
		new_pos=Vector2(tl.x,tl.y + r)
		if(fond.get_cellv(new_pos) == 2):
			explosion.set_cellv(new_pos,1)
		else:
			break
		r+=1
	explosion.set_cellv(new_pos,2)
