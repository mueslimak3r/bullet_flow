extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var filled = {}
var map_x
var map_y
var v_tex = load("res://art/pipe/pipe_end.png")
var source_location
var sink_location

func _ready():
	$Sprite.texture = v_tex
	pass

func start() :
	print("map: x: " + str(map_x) + " y: " + str(map_y))
	source_location = Vector2(map_x / 2, map_y / 2) + get_parent().get_node("BG").world_to_map(self.get_global_position())
	print(str(sink_location))
	#var pipe_out = get_parent().find_node("pipe_out")
	#print(pipe_out.get_name())
	#var pipe_out = get_parent().find_node("pipe_out")
	#sink_location = Vector2(map_x / 2, map_y / 2) + get_parent().get_node("BG").world_to_map(pipe_out.get_global_position())
	for loop_y in map_y :
		var y = loop_y
		filled[y] = {}
		for x in map_x :
			filled[y][x] = "empty"
	var sourcey = int(source_location.y) - 1
	var sourcex = int(source_location.x) - 1
	var sink_x = int(sink_location.x) - 1
	var sink_y = int(sink_location.y) - 1
	filled[sourcey][sourcex] = "source"
	filled[sink_y][sink_x] = "sink"

func check_pipe(current, type, dir) :
	if type ==  "horizontal" :
		if current == "source" and dir == "right" || current == "sink" and dir == "left":
			return true
		if ((current == "top_left" or current == "bottom_left" or current == "horizontal") and dir == "right") or ((current == "top_right" or current == "bottom_right" or current == "horizontal") and dir == "left") :
			return true
	if (type == "bottom_right") :
		if current == "source" and dir == "right" :
			return true
		if ((current == "top_right" or current == "top_left" or current == "vertical") and dir == "under") or ((current == "top_left" or current == "bottom_left" or current == "horizontal") and dir == "right") :
		#or ((type == "top_left" or type == "bottom_left" or type == "horizontal") and dir == "left"):
			return true
	if type == "bottom_left" :
		if current == "sink" and dir == "left" :
			return true
		if ((current == "top_right" or current == "top_left" or current == "vertical") and dir == "under") or ((current == "top_right" or current == "bottom_right" or current == "horizontal") and dir == "left") :
			return true
	if type == "top_right" :
		if current == "source" and dir == "right" :
			return true
		if ((current == "bottom_left" or current == "bottom_right" or current == "vertical") and dir == "over") or ((current == "top_left" or current == "bottom_left" or current == "bottom_right" or current == "horizontal") and dir == "right") :
			return true
	if type == "vertical" :
		if ((current == "bottom_left" or current == "bottom_right" or current == "vertical") and dir == "over") or ((current == "top_right" or current == "top_left" or current == "vertical") and dir == "under") :
			return true
	if type == "top_left" :
		if current == "sink" and dir == "left" :
			return true
		if ((current == "top_right" or current == "bottom_right" or current == "horizontal") and dir == "left") or ((current == "bottom_left" or current == "bottom_right" or current == "vertical") and dir == "over") :
			return true
	return false

func connect_pipe(_position, type) :
	var origin = Vector2(map_x / 2, map_y / 2)
	var hit_vector = origin + _position
	var hit_x = int(hit_vector.x) - 2
	var hit_y = int(hit_vector.y) - 1
	var to_save = false
	if hit_x < 0 :
		hit_x = 0
	if hit_y < 0 :
		hit_y = 0
	print("x: " + str(hit_x) + " y: " + str(hit_y))
	print(str(source_location))
	if filled.has(hit_y) and filled[hit_y].has(hit_x + 2) and filled[hit_y][hit_x + 1] == "source" and check_pipe("source", type, "right") :
		print("hit source")
		to_save = true
	if filled.has(hit_y) and filled[hit_y].has(hit_x - 2) and filled[hit_y][hit_x - 1] == "sink" and check_pipe("sink", type, "left") :
		print("hit sink")
		global.player.get_node("CanvasLayer").get_node("Sprite/good job!").set_visible(true)
		to_save = true
	if filled.has(hit_y + 1) and filled[hit_y + 1].has(hit_x) :
		print(filled[hit_y + 1][hit_x])
		if check_pipe(filled[hit_y + 1][hit_x], type, "under") :
			to_save = true
	if filled.has(hit_y - 1) and filled[hit_y - 1].has(hit_x) :
		print(filled[hit_y - 1][hit_x])
		if check_pipe(filled[hit_y - 1][hit_x], type, "over") :
			to_save = true
	if filled.has(hit_y) and filled[hit_y].has(hit_x + 1) :
		print(filled[hit_y][hit_x + 1])
		if check_pipe(filled[hit_y][hit_x + 1], type, "right"):
			to_save = true
	if filled.has(hit_y) and filled[hit_y].has(hit_x - 1) :
		print(filled[hit_y][hit_x - 1])
		if check_pipe(filled[hit_y][hit_x - 1], type, "left"):
			to_save = true
	if to_save == true :
		filled[hit_y][hit_x] = type
		return true
	#var position2 = get_parent().get_global_position() - Vector2(map_x / 2, map_y / 2)
	#print(str(position2))
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
