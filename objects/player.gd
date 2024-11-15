extends CharacterBody2D


const movespeed = 5
const movespeed_slow = 2
#var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var new_velocity = Vector2.ZERO
	var show_collide_box = false
	var this_movespeed = movespeed
	
	if Input.is_action_pressed("move_up"):
		new_velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		new_velocity.y += 1
	if Input.is_action_pressed("move_left"):
		new_velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		new_velocity.x += 1
	
	if Input.is_action_pressed("modify"):
		show_collide_box = true
		this_movespeed = movespeed_slow
	
	velocity = new_velocity
	move_and_collide(velocity * this_movespeed)
	
	$Collider_shape.visible = show_collide_box
