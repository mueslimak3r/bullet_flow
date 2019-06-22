extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var br_tex = load("res://art/pipe/bottom_right/pipe_corner_bottom_right.png")
var bl_tex = load("res://art/pipe/bottom_left/pipe_corner_bottom_left.png")
var tr_tex = load("res://art/pipe/top_right/pipe_corner_top_right.png")
var tl_tex = load("res://art/pipe/top_left/pipe_corner_top_left.png")
var h_tex = load("res://art/pipe/horizontal/pipe_horizontal.png")
var v_tex = load("res://art/pipe/vertical/pipe_vertical.png")


var type = "horizontal"
var owned = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (type == "horizontal"):
		$Sprite.texture = h_tex
	if (type == "vertical"):
		$Sprite.texture = v_tex
	if (type == "bottom_left"):
		$Sprite.texture = bl_tex
	if (type == "bottom_right"):
		$Sprite.texture = br_tex
	if (type == "top_left"):
		$Sprite.texture = tl_tex
	if (type == "top_right"):
		$Sprite.texture = tr_tex

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (owned == 0):
		rotate(delta)

func _on_Area2D_body_entered(body):
	if ("player" in body.get_parent() and owned != 1):
		body.get_parent().pieces[type] += 1
		print("PLAYER PICKED UP " + type + " PIPE! TOTAL: " + str(body.get_parent().pieces[type]))
		queue_free()
