extends Node2D

# Enemy Control block
# Has a flashing up arrow

# Time 1 - 4s - WarningArrow Flashing Normally (3,2, 5FPS)
# Time 2 - 5s (+1s) - WarningArrow Flashing Fast (3,2,10FPS)
# Launch Bus.
# 1s later; remove warning arrow.

signal player_hit

const distance_above_world = 110
const dbprefix = "ENEMYCONTROL"

const time_1 = 4
const time_2 = 1
const time_3 = 1

var state = 0
var enemy_node = preload("res://objects/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_timer(time_1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func cleanup() -> void:
	print(dbprefix,":Being Destroyed")
	queue_free()

func launch_bus() -> void:
	var this_enemy = enemy_node.instantiate()
	this_enemy.position = Vector2(0, -1*distance_above_world)
	
	get_node(".").add_child(this_enemy)
	this_enemy.connect("tree_exiting", Callable(self, "cleanup"))
	this_enemy.connect("player_hit", func(): emit_signal("player_hit"))
	print(dbprefix,":Launched bus at ",self.position)

func set_timer(waittime: float) -> void:
	$Timer.wait_time = waittime
	$Timer.start()

func _on_timer_timeout() -> void:
	if state == 0:
		state = 1
		set_timer(time_2)
		$WarningArrow.animation = "fast"
		print(dbprefix,":timer set to state 1")
	elif state == 1:
		state = 2
		set_timer(time_3)
		launch_bus()
		print(dbprefix,":timer set to state 2")
	elif state == 2:
		state = 3
		$WarningArrow.visible = false
		print(dbprefix,":timer set to state 3")
