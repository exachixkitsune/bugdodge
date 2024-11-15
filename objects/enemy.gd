extends Area2D

signal player_hit

var velocity = Vector2(0, 3.4)
var has_been_on_screen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity.y -= randf_range(-0.4,0.4)
	print("ENEMY:Speed set to ",velocity.y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = position + velocity


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	emit_signal("player_hit")

func _on_tree_exiting() -> void:
	pass # Replace with function body.
