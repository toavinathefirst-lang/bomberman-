extends Node2D

var xp = 0
var lvl = 1

var col
var row
var walls = []
const TILE = 64

# Assurez-vous que ces chemins correspondent à votre projet
onready var mur = preload("res://prefab/mur.tscn")
onready var item = preload("res://prefab/item.tscn")
onready var hero = $player

func _ready():
	randomize()
	# Calcul du nombre de colonnes et lignes
	col = int(get_viewport().size.x / TILE)
	row = int(get_viewport().size.y / TILE)
	
	walls = dimension_Array(col, row)
	spawnWalls()
	spawnItem()
	applyGrass()
func applyGrass():
	for x in col:
		for y in row:
			$grass_Tile.set_cell(x,y,randi()%4)
func dimension_Array(cols, rows):
	var m = []
	for x in range(cols):
		m.append([])
		for y in range(rows):
			# Godot 3 : randi() % 101 donne un nombre entre 0 et 100
			var z = randi() % 101
			if z > 25:
				m[x].append(0)
			else:
				m[x].append(1)
	return m

func recup_loot(value):
	print("j ai récupéré l item " + str(value))

func spawnItem():
	var screen_size = get_viewport().size
	var screenTile = screen_size / Vector2(TILE, TILE)
	
	for i_loop in range(25):
		var pointx = floor(randi() % int(screenTile.x))
		var pointy = floor(randi() % int(screenTile.y))
		
		var point = Vector2(pointx * TILE + (TILE / 2), pointy * TILE + (TILE / 2))
		
		var i = item.instance()
		# Syntaxe de connexion Godot 3 : (nom_du_signal, cible, nom_fonction)
		i.connect("loot", self, "recup_loot")
		i.start(point, randi() % 4)
		add_child(i)

func spawnWalls():
	for x in range(col):
		for y in range(row):
			if walls[x][y] == 1:
				var w = mur.instance()
				# Inversion x/y pour correspondre à la logique de positionnement Vector2(x, y)
				w.position = Vector2(x * TILE + (TILE / 2), y * TILE + (TILE / 2))
				add_child(w)
