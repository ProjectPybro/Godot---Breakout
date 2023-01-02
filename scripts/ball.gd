extends RigidBody2D

const SPEED_UP = 10
const MAX_SPEED = 500

func _ready():
	set_physics_process(true)
	randomize()
	modulate = (Color(randf(), randf(), randf(), 1.0)) # Randomises the balls color


func _physics_process(delta):
	var collision_list = get_colliding_bodies() # Gets a list of all the collisions 
												# (maximum of 10 due to Contact Report set to 10)
												# Remember to make sure Conact Monitor set to true! 
	for collision in collision_list:
		if "Brick" in collision.name:
			collision.queue_free() # If collided with a brick, destroy the brick
			get_node("/root/World").score += 1
			
		if collision.get_name() == "Paddle":
			var speed = linear_velocity.length()
			var direction = position - collision.get_node("Anchor").get_global_position()
			var velocity = direction.normalized()*min(speed+SPEED_UP, MAX_SPEED) 
			set_linear_velocity(velocity) 
			
			""" 
			The direction is bounce to is found by using a 2d point below the paddle known as anchor.
			This just avoids having to do complex maths 
			
			This increases the velocity by either SPEED_UP, or MAX_SPEED, whichever is smaller.
			This stops the velocity ever being faster than MAX_SPEED.
			* by delta is not needed since we are only changing velocity
			while GODOT changes the x and y values, and so GODOT will apply delta by itself 
			"""
			
	if position.y > get_viewport_rect().end.y: # If the ball hits the bottom
		queue_free()
 
