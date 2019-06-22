extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 50
var velocity = Vector2()
var health = 100
var damage = 10

var attack_timer = Timer.new()
var attack_speed = 1
var attack_range = 100

var anim = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	attack_timer.connect("timeout", self, "attack")
	attack_timer.set_wait_time(attack_speed)
	add_child(attack_timer)
	attack_timer.start()

func attack():
	var player_node = get_parent().find_node("player").find_node("KinematicBody2D")
	var pos = player_node.position
	if ((pos - $KinematicBody2D.global_position).length() <= attack_range && player_node.get_parent().health > 0):
		player_node.get_parent().health -= 15
		anim = "attack"
		print("REGISTER")
	else:
		anim = "idle"
	pass

func seek_player() :
	var player_node = get_parent().find_node("player").find_node("KinematicBody2D")
	var pos = player_node.position
	velocity = (pos - $KinematicBody2D.global_position).normalized() * speed
	if (pos - $KinematicBody2D.global_position).length() > (attack_range * 0.75):
		velocity = $KinematicBody2D.move_and_slide(velocity)

func _process(delta):
	$KinematicBody2D/AnimatedSprite.play(anim)
	seek_player()
	if (health <= 0):
		queue_free()
	if (global_position.x < get_parent().find_node("player").find_node("KinematicBody2D").position.x):
		$KinematicBody2D/AnimatedSprite.flip_h = true
	else:
		$KinematicBody2D/AnimatedSprite.flip_h = false

func _on_Area2D_body_entered(body):
	if (body and "damage" in body.get_parent()):
		health -= body.get_parent().damage
		print("HEALTH: " + str(health))
	pass # Replace with function body.
