extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t = 0
var targetpos = Vector2()
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = (targetpos - position).normalized() * 600
	$KinematicBody2D.rotation = velocity.angle()
	if (targetpos - position).length() > 5:
		velocity = $KinematicBody2D.move_and_slide(velocity)
	if ($KinematicBody2D.position == targetpos):
		queue_free()
