extends Node2D

signal spawn_enemy()
signal stop_game(score: int)
signal do_splat()
signal do_point()

const min_interval = 30
const max_interval = 60

# Game Info
var points = 0

const enum_state_running = 0
const enum_state_paused = 1
var gamestate = enum_state_running

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_timer(randi_range(5,9))
	$UIBox/ProgressBar/TextureProgressBar.max_value = $Point_Timer.wait_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var value = $Point_Timer.wait_time - $Point_Timer.time_left
	$UIBox/ProgressBar/TextureProgressBar.value = $Point_Timer.wait_time - $Point_Timer.time_left

func _on_enemy_spawn_timer_timeout() -> void:
	emit_signal("spawn_enemy")
	reset_timer()

func reset_timer() -> void:
	set_timer(randi_range(min_interval,max_interval))

func set_timer(time: float) -> void:
	print("GAMECONTROL:Timer to next entity: ",time)
	$Enemy_Spawn_Timer.wait_time = time
	$Enemy_Spawn_Timer.start()

func _on_point_timer_timeout() -> void:
	incr_points()
	emit_signal("do_point")

func incr_points() -> void:
	points += 1
	update_points_label()

func change_points(new_points: int) -> void:
	points = new_points
	update_points_label()

func update_points_label() -> void:
	$UIBox/Points_Label_num.text = str(points)

func _on_world_player_hit() -> void:
	emit_signal("do_splat")
	# Stop game
	emit_signal("stop_game", points)
