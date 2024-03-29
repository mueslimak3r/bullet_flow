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
var spawned_source = false
# Called when the node enters the scene tree for the first time.
func _ready() : 
	wave_timer.connect("timeout", self, "spawn_wave")
	wave_timer.set_wait_time(wave_delay)
	add_child(wave_timer)
	wave_timer.start()
	
	#fill_map()
	gen_square_room()
	link_neighbors()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fill_map():
	for n in range(0,255):
		for m in range(0,255):
			set_cell(n - 127, m - 127, 3)

func spawn_wave():
	if get_parent().get_parent().find_node("player").in_room != get_parent().get_name() :
		return
	for i in wave_size:
		randomize()
		var mob = load(mobs[randi() % mobs.size()])
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

func spawn_sink(spawn_inst) :
	var source = load("res://sink.tscn")
	var inst = source.instance()
	var source_pos_x = int(offset.x)
	var source_pos_y = int(offset.y)
	randomize()
	while ((source_pos_y % mapsize) == 0):
		source_pos_y = randi() % mapsize
	if !(source_pos_x == mapsize or source_pos_y == mapsize) :
		source_pos_x = mapsize
	 #Vector2(offset.x, offset.y) - Vector2(5, 5))
	#inst.global_position = map_to_world(Vector2((mapsize - 4) / 2, source_pos_y - (mapsize / 2)))
	get_parent().add_child(inst)
	inst.global_position = world_to_map(map_to_world(Vector2(-25, 25)))
	spawn_inst.sink_location = Vector2(mapsize / 2, mapsize / 2) + world_to_map(inst.get_global_position())
	spawn_inst.start()

func spawn_source():
	if spawned_source == true :
		return
	spawned_source = true
	var source = load("res://source.tscn")
	var inst = source.instance()
	inst.map_x = mapsize
	inst.map_y = mapsize
	var source_pos_x = int(offset.x)
	var source_pos_y = int(offset.y)
	randomize()
	while ((source_pos_y % mapsize) == 0):
		source_pos_y = randi() % mapsize
	if !(source_pos_x == mapsize or source_pos_y == mapsize) :
		source_pos_x = mapsize
	 #Vector2(offset.x, offset.y) - Vector2(5, 5))
	#inst.global_position = map_to_world(Vector2((mapsize - 4) / 2, source_pos_y - (mapsize / 2)))
	get_parent().add_child(inst)
	inst.global_position = world_to_map(map_to_world(Vector2(mapsize - 1, source_pos_y - (mapsize / 2))))
	spawn_sink(inst)

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