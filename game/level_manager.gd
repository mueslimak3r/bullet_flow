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
	room.weight = 1
	rooms.push_front(room)
	var level1 = lvl_asset.instance()
	var i = 0
	while (rooms.size() > 0):
		print("ROOM")
		var offsets_list = []
		for n in range(0, 3):
			if randi() % rooms[0].weight == 0:
				room = {}
				randomize()
				room.size = (randi() % 30) + 30
				var neg = Vector2()
				if (randi() % 2 == 1):
					neg.x = 1
				else:
					neg.x = -1
				if (randi() % 2 == 1):
					neg.y = 1
				else:
					neg.y = -1
				room.offset = rooms[0].offset + Vector2((room.size * 2) * neg.x, (room.size * 2) * neg.y)
				var exist = false
				for n in offsets_list:
					if room.offset.x == n.x and room.offset.y == n.y:
						exist = true
				if (exist == false):
					offsets_list.push_back(room.offset)
					room.neighbors = []
					room.weight = rooms[0].weight * 2
					room.neighbors.push_back(rooms[0])
					rooms[0].neighbors.push_back(room)
					#if (i == 0):
						#rooms[0].neighbors.push_back(room)
					rooms.push_back(room)
		var new_level = lvl_asset.instance()
		new_level.get_node("BG").offset = rooms[0].offset
		new_level.get_node("BG").mapsize = rooms[0].size
		new_level.set_name("level" + str(i + 1))
		new_level.get_node("BG").neighbors = rooms[0].neighbors
		add_child(new_level)
		print("ROOM " + str(room.offset))
		rooms.pop_front()
		i += 1
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
