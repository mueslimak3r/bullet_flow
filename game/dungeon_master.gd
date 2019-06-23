extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var map = []

var mapsize = 30
var offset = Vector2()

var wave_timer = Timer.new()
var wave_size = 1
var wave_delay = 10
var neighbors = []
var mobs = [ "res://scenes/characters/hell_beast_weak.tscn" , "res://scenes/characters/flying_demon.tscn" , "res://scenes/characters/hell_beast_strong.tscn"] 

# Called when the node enters the scene tree for the first time.
func _ready() : 
	wave_timer.connect("timeout", self, "spawn_wave")
	wave_timer.set_wait_time(wave_delay)
	add_child(wave_timer)
	wave_timer.start()
	
	#fill_map()
	gen_square_room()
	spawn_source()
	link_neighbors()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fill_map():
	for n in range(0,255):
		for m in range(0,255):
			set_cell(n - 127, m - 127, 3)

func spawn_wave():
	var mob = load("res://scenes/characters/flying_demon.tscn")
	for i in wave_size:
		var inst = mob.instance()
		get_parent().add_child(inst)
		var source_pos_x = int(offset.x)
		var source_pos_y = int(offset.y)
		randomize()
		while ((source_pos_x % mapsize) == 0):
			source_pos_x = randi() % mapsize
		while ((source_pos_y % mapsize) == 0):
			source_pos_y = randi() % mapsize
		inst.global_position = map_to_world(Vector2(source_pos_x - (mapsize / 2), source_pos_y - (mapsize / 2)))

func spawn_source():
	var source = load("res://source.tscn")
	var inst = source.instance()
	var source_pos_x = int(offset.x)
	var source_pos_y = int(offset.y)
	add_child(inst)
	randomize()
	while ((source_pos_y % mapsize) == 0):
		source_pos_y = randi() % mapsize
	inst.global_position = map_to_world(Vector2((mapsize - 4) / 2, source_pos_y - (mapsize / 2)))

func gen_square_room():
	map.resize(mapsize)
	for n in mapsize:
		map[n] = []
		map[n].resize(mapsize)
		for m in mapsize:
			if (n % (mapsize - 2) == 0 or m % (mapsize - 2) == 0):
				map[n][m] = 0
			else:
				map[n][m] = -1
	for n in range(0, mapsize - 1):
		for m in range(0, mapsize - 1):
			if map[n][m] == 0:
				set_cell(n - int(offset.x), m - int(offset.y), 2)
			else:
				set_cell(n - int(offset.x), m - int(offset.y), 3)

func link_neighbors():
	for room in 0:
		var curpos = Vector2()
		var os1 = 1
		var os2 = 1
		if (room.offset.x < offset.x):
			os1 = -1
		if (room.offset.y < offset.y):
			os2 = -1
		while (room.offset.x * os1 > offset.x + curpos.x):
			set_cell(offset.x + curpos.x, -offset.y, 3)
			curpos.x += 1
		while (room.offset.y * os2 > offset.y + curpos.y):
			set_cell(offset.x + (curpos.x * os2), -(offset.y + (curpos.y * os2)), 3)
			curpos.y += 1
		print("HI")