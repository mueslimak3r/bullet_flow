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
var in_room = ""
var state = "combat"
var selected_pipe = "horizontal"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.offset = get_viewport().size / 2
	pieces.horizontal = 0
	pieces.top_left = 0
	pieces.top_right = 0
	pieces.bottom_left = 0
	pieces.bottom_right = 0
	pieces.vertical = 0

func update_ui():
	$CanvasLayer/Sprite/inventory/horiz.text = str(pieces.horizontal)
	$CanvasLayer/Sprite/inventory/vert.text = str(pieces.vertical)
	$CanvasLayer/Sprite/inventory/bl.text = str(pieces.bottom_left)
	$CanvasLayer/Sprite/inventory/br.text = str(pieces.bottom_right)
	$CanvasLayer/Sprite/inventory/tl.text = str(pieces.top_left)
	$CanvasLayer/Sprite/inventory/tr.text = str(pieces.top_right)

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
		if (Input.is_action_pressed("build")):
			state = "build"
		if (Input.is_action_pressed("combat")):
			state = "combat"
		if Input.is_action_pressed("1"):
			selected_pipe = "horizontal"
		if Input.is_action_pressed("2"):
			selected_pipe = "vertical"
		if Input.is_action_pressed("3"):
			selected_pipe = "bottom_left"
		if Input.is_action_pressed("4"):
			selected_pipe = "bottom_right"
		if Input.is_action_pressed("5"):
			selected_pipe = "top_left"
		if Input.is_action_pressed("6"):
			selected_pipe = "top_right"
		velocity = velocity.normalized() * 200

func _input(event):
	if (event.is_action_pressed("fire")):
		if (state == "combat" and health > 0):
			var proj = load("res://scenes/projectile.tscn")
			var inst = proj.instance()
			get_parent().add_child(inst)
			inst.position = $KinematicBody2D.position
			inst.targetpos = get_global_mouse_position()
		if (state == "build" and health > 0):
			if (self.pieces[selected_pipe] > 0):
				var pipe = load("res://pipe_piece.tscn")
				var inst = pipe.instance()
				inst.owned = 1
				inst.type = selected_pipe
				inst.ghost = 0
				get_parent().add_child(inst)
				inst.position = get_parent().get_node("room1").find_node("BG").map_to_world(get_parent().get_node("room1").find_node("BG").world_to_map(get_global_mouse_position())) + Vector2(8,8)
				self.pieces[selected_pipe] -= 1
	if (event is InputEventMouseMotion and state == "build"):
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	update_ui()
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
	var pipenode = get_parent().find_node("ghost_pipe")
	if (state == "build" and pipenode):
		pipenode.type = selected_pipe
		pipenode.update_texture()
		pipenode.visible = true
	else:
		if (pipenode):
			pipenode.visible = false
