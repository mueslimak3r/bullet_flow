extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lvl_asset = load("res://scenes/levels/room1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var level1 = lvl_asset.instance()
	level1.get_node("BG").offset = Vector2(15, 15)
	$player.in_room = "level1"
	add_child(level1)
	var level2 = lvl_asset.instance()
	level2.get_node("BG").offset = Vector2(50, 50)
	add_child(level2)
	#var lvl_asset2 = load("res://scenes/levels/room1.tscn")
	#var level2 = lvl_asset.instance()
	#add_child(level2)
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
