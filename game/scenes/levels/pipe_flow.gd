extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var filled = {}
var map_x
var map_y
var source_x
var source_y

func _ready():
	pass

func start() :
	print("x: " + str(map_x) + " y: " + str(map_y)) 
	filled.y = {}
	for loop_y in map_y :
		var y = loop_y
		filled.y[y] = {}
		for x in map_x :
			filled.y[y].x = "empty"
	#filled.y[source_y].source_x = "source"

func connect_pipe(_position) :
	print(str(_position))
	var position2 = get_parent().get_global_position()
	print(str(position2))
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
