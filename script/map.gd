extends Node2D

onready var fond:TileMap = $fond
onready var player = preload("res://prefab/player.tscn")
onready var enemy = preload("res://prefab/enemy.tscn")
onready var explosion = $explosion

export(int) var force = 2

func _ready():
	spawn(10)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		var _err = get_tree().reload_current_scene()

func spawn(nombre:int):
	randomize()
	var lst = fond.get_used_cells_by_id(1)
	for tuile in lst:
		match randi() % 4:
			0:
				if fond.get_cell(tuile.x + 1, tuile.y) == 2:
					fond.set_cell(tuile.x + 1, tuile.y, 3)
			1:
				if fond.get_cell(tuile.x - 1, tuile.y) == 2:
					fond.set_cell(tuile.x - 1, tuile.y, 3)
			2:
				if fond.get_cell(tuile.x, tuile.y + 1) == 2:
					fond.set_cell(tuile.x, tuile.y + 1, 3)
			3:
				if fond.get_cell(tuile.x, tuile.y - 1) == 2:
					fond.set_cell(tuile.x, tuile.y - 1, 3)
	
	# CORRECTION : Utilisation du point (0.1) au lieu de la virgule (0,1)
	yield(get_tree().create_timer(0.1), "timeout")
	creation_player_and_mob(nombre)

func creation_player_and_mob(nombre:int):
	var tileGrassList = fond.get_used_cells_by_id(2)
	
	# SÉCURITÉ : On vérifie si la liste n'est pas vide pour éviter "Division by zero"
	if tileGrassList.size() == 0:
		print("Erreur : Aucune tuile d'herbe (ID 2) disponible pour le spawn !")
		return

	for x in range(nombre + 1):
		var obj
		if x == 0:
			obj = player.instance()
		else:
			obj = enemy.instance()
		
		# CORRECTION : Le modulo ne plantera plus car size() est > 0 ici
		var tuile_rn = tileGrassList[randi() % tileGrassList.size()]
		var offset = fond.map_to_world(tuile_rn)
		
		# On centre l'objet sur la tuile (en supposant des tuiles de 64x64)
		obj.position = Vector2(offset.x + 32, offset.y + 32)
		add_child(obj)

func explode(post:Vector2):
	var new_pos
	var tl = explosion.world_to_map(post)
	var lst_explo = [] # Nettoyé ici
	var lst_fond=[]
	# CENTER
	explosion.set_cellv(tl, 0)
	lst_explo.append(tl)
	
	for z in range(3, 7):
		var r = 1
		var hv = 1
		while r <= force:
			match z:
				3:
					new_pos = Vector2(tl.x, tl.y - r)
					hv = 1
				4:
					new_pos = Vector2(tl.x + r, tl.y)
					hv = 2
				5:
					new_pos = Vector2(tl.x, tl.y + r)
					hv = 1
				6:
					new_pos = Vector2(tl.x - r, tl.y)
					hv = 2
			
			if fond.get_cellv(new_pos) == 2:
				explosion.set_cellv(new_pos, hv)
				lst_explo.append(new_pos)
			else:
				break
			r += 1
			
		# On place la tuile d'extrémité 
		explosion.set_cellv(new_pos, z)
		lst_explo.append(new_pos)
		if fond.get_cellv(new_pos)==3:
			fond.set_cellv(new_pos,4)
			lst_fond.append(new_pos)
		
	yield(get_tree().create_timer(0.7), "timeout")
	for t in lst_explo:
		explosion.set_cellv(t, -1)
	for b in lst_fond:
		 fond.set_cellv(b,2)
