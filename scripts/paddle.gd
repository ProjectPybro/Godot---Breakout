extends KinematicBody2D


const ball_scene = preload("res://scenes/other_scenes/ball.tscn")
var mouse_position = 0


func _ready():
	set_physics_process(true)

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	global_position.x = mouse_position.x

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var ball = ball_scene.instance() # Create the ball from the ball scene
		ball.position = position - Vector2(0, 30) # Set the balls position above the paddle
		get_tree().get_root().add_child(ball) # Adds the ball to the node list
