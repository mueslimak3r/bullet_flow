extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lvl_asset = load("res://scenes/levels/room1.tscn")
var rooms = []
# Called when the node enters the scene tree for the first time.

func overlaps(room1, room2):
	for n in room1.size:
		for m in room2.size:
			if (n + room1.offset.x == m + room2.offset.x):
				return true
			if (n + room2.offset.y == m + room2.offset.y):
				return true
	return false

func _ready():
	var room = {}
	randomize()
	room.size = (randi() % 30) + 30
	room.offset = Vector2(room.size / 2, room.size / 2)
	room.neighbors = []
	rooms.push_front(room)
	var level1 = lvl_asset.instance()
	#var i = 0
	#while (rooms.size() > 0):
	#	for n in range(0, 3):
	#		if randi() % 3 == 0:
	#			room = {}
	#			randomize()
	#			room.size = 30
	#			var neg = Vector2()
	#			if (randi() % 2 == 1):
	#				neg.x = 1
	#			else:
	#				neg.x = -1
	#			if (randi() % 2 == 1):
	#				neg.y = 1
	#			else:
	#				neg.y = -1
	#			room.offset = rooms[0].offset + Vector2((rooms[0].size * 2) * neg.x, (rooms[0].size * 2) * neg.y)
	#			room.neighbors = []
	#			room.neighbors.push_back(rooms[0])
	#			rooms.push_back(room)
	#	var new_level = lvl_asset.instance()
	#	new_level.get_node("BG").offset = rooms[0].offset
	#	new_level.get_node("BG").mapsize = rooms[0].size
	#	new_level.set_name("level" + str(i + 1))
	#	new_level.get_node("BG").neighbors = rooms[0].neighbors
	#	add_child(new_level)
	#	#if new_level.get_node("BG").spawned_source == false :
	#	var spawned_source = false
	#	if spawned_source == false :
	#		spawned_source = true
	#		new_level.get_node("BG").spawn_source()
	#	print("ROOM " + str(room.offset))
	#	rooms.pop_front()
	#	i += 1
	level1.set_name("level1")
	level1.get_node("BG").offset = Vector2(15, 15)
	level1.get_node("BG").mapsize = 30
	add_child(level1)
	level1.get_node("BG").spawn_source()
	#level1.get_node("BG").offset = Vector2(15, 15)
	$player.in_room = "level1"
	#add_child(level1)
	#var level2 = lvl_asset.instance()
	#level2.get_node("BG").offset = Vector2(50, 50)
	#add_child(level2)
	#var lvl_asset2 = load("res://scenes/levels/room1.tscn")
	#var level2 = lvl_asset.instance()
	#add_child(level2)
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
