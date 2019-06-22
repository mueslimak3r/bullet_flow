extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var anim = "default"
var flip = 0
var velocity = Vector2()
var health = 100
var player = true
var pieces = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.offset = get_viewport().size / 2
	var node = $Camera2D
	remove_child(node)
	$KinematicBody2D.add_child(node)
	pieces.horizontal = 0
	pieces.top_left = 0
	pieces.top_right = 0
	pieces.bottom_left = 0
	pieces.bottom_right = 0
	pieces.vertical = 0

func get_input():
	velocity = Vector2()
	if (health > 0):
		if (Input.is_action_pressed("move_left")):
			flip = 1
		else:
			flip = 0
		if (Input.is_action_pressed("move_up")):
			anim = "run_up"
			velocity.y -= 1
		if (Input.is_action_pressed("move_down")):
			anim = "run_down"
			velocity.y += 1
		if (Input.is_action_pressed("move_right")) or (Input.is_action_pressed("move_left")):
			anim = "run_side"
		if (Input.is_action_pressed("move_right")):
			velocity.x += 1
		if (Input.is_action_pressed("move_left")):
			velocity.x -= 1
		velocity = velocity.normalized() * 200

func _input(event):
	if (event.is_action_pressed("fire")):
		var proj = load("res://scenes/projectile.tscn")
		var inst = proj.instance()
		get_parent().add_child(inst)
		inst.position = $KinematicBody2D.position
		inst.targetpos = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	if (flip):
		$KinematicBody2D/AnimatedSprite.flip_h = true
	else:
		$KinematicBody2D/AnimatedSprite.flip_h = false
	if (velocity.x == 0 && velocity.y == 0):
		if (health > 0):
			anim = "default"
		else:
			anim = "die"
	$KinematicBody2D/AnimatedSprite.play(anim)
	velocity = $KinematicBody2D.move_and_slide(velocity)
