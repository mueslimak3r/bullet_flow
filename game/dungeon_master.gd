extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var map = []

var mapsize = 24

var wave_timer = Timer.new()
var wave_size = 1
var wave_delay = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	wave_timer.connect("timeout", self, "spawn_wave")
	wave_timer.set_wait_time(wave_delay)
	add_child(wave_timer)
	wave_timer.start()
	
	fill_map()
	gen_square_room()
	spawn_source()

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
		var source_pos_x = 0
		var source_pos_y = 0
		randomize()
		while ((source_pos_x % mapsize) == 0):
			source_pos_x = randi() % mapsize
		while ((source_pos_y % mapsize) == 0):
			source_pos_y = randi() % mapsize
		inst.global_position = map_to_world(Vector2(source_pos_x - (mapsize / 2), source_pos_y - (mapsize / 2)))

func spawn_source():
	var source = load("res://source.tscn")
	var inst = source.instance()
	var source_pos_x = 0
	var source_pos_y = 0
	add_child(inst)
	randomize()
	while ((source_pos_x % mapsize) == 0):
		source_pos_x = randi() % mapsize
	while ((source_pos_y % mapsize) == 0):
		source_pos_y = randi() % mapsize
	inst.global_position = map_to_world(Vector2(source_pos_x - (mapsize / 2), source_pos_y - (mapsize / 2)))

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
				set_cell(n - (mapsize / 2), m - (mapsize / 2), 2)
			else:
				set_cell(n - (mapsize / 2), m - (mapsize / 2), 3)