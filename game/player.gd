extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var anim = "default"
var flip = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if (event.is_action_pressed("move_left")):
		flip = 1
	else:
		flip = 0
	if (event.is_action_pressed("move_up")):
		anim = "run_up"
		
	if (event.is_action_pressed("move_down")):
		anim = "run_down"
	if (event.is_action_pressed("move_right")) or (event.is_action_pressed("move_left")):
		anim = "run_side"
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.play(anim)
