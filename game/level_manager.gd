extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var lvl_asset = load("res://scenes/levels/room1.tscn")
	var level1 = lvl_asset.instance()
	add_child(level1)
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
