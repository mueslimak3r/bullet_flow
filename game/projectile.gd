extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t = 0
var targetpos = Vector2()
var velocity = Vector2()
var damage = 15
var lastpos = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = (targetpos - position).normalized() * 600
	$KinematicBody2D.rotation = velocity.angle()
	if (targetpos - position).length() > 5:
		velocity = $KinematicBody2D.move_and_slide(velocity)
	if (lastpos != null):
		if (lastpos.x == $KinematicBody2D.global_position.x or lastpos.y == $KinematicBody2D.global_position.y):
			queue_free()
	lastpos = $KinematicBody2D.global_position

func _on_Area2D_body_entered(body):
	if !("player" in body.get_parent()):
		queue_free()

func _on_Area2D_area_entered(area):
	#print("HELLO")
	queue_free()


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	#print("TEST")
	pass # Replace with function body.
