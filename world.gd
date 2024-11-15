extends Node2D

signal player_hit()

const width = 400
const height = 600


const background_delta = 1
const image_height = 1036

var enemy_control_node = preload("res://procedures/enemy_control.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Limiter - ensure player is always within walls
	if $Player.position.x < 0:
		$Player.position.x = 0
	elif $Player.position.x > width:
		$Player.position.x = width
	if $Player.position.y < 0:
		$Player.position.y = 0
	elif $Player.position.y > height:
		$Player.position.y = height

	$RoadWay.region_rect.position.y -= background_delta
	if $RoadWay.region_rect.position.y < 0:
		print("WORLD:Cycling Background")
		$RoadWay.region_rect.position.y += image_height
		


func spawn_enemy() -> void:
	# Spawn above the player
	var spawn_loc = Vector2($Player.position.x, 0)
	var this_enemy_control = enemy_control_node.instantiate()
	this_enemy_control.position = spawn_loc
	get_node(".").add_child(this_enemy_control)
	this_enemy_control.connect("player_hit",func(): emit_signal("player_hit"))
	
func _on_game_control_spawn_enemy() -> void:
	spawn_enemy()
	pass # Replace with function body.


func _on_game_control_stop_game(_score: int) -> void:
	print("WORLD:Stop signal received")
	get_tree().paused = true
