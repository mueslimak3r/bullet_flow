extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var v_tex = load("res://art/pipe/pipe_end.png")
var location

func _ready():
	$Sprite.texture = v_tex
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
