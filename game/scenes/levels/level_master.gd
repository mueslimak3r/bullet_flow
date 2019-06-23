extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var map_asset = load("res://level1.tscn")
	var level1 = map_asset.instance()
	add_child(level1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
