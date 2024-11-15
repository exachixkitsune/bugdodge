extends Node2D

const splat_node = preload("res://UI/Bugsplat_splash.tscn")
const point_node = preload("res://UI/Point_splash.tscn")
const endgame_node = preload("res://UI/gameover.tscn")

const anim_center = Vector2(469,324)
const ordering_level = 2000

var close_enabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func bind_gamecontrol(gamecontrolfile: Resource) -> void:
	var gamecontrol_node = gamecontrolfile.instantiate()
	gamecontrol_node.z_index = 750
	get_node(".").add_child(gamecontrol_node)
	gamecontrol_node.do_point.connect(_on_game_control_endless_do_point)
	gamecontrol_node.do_splat.connect(_on_game_control_endless_do_splat)
	gamecontrol_node.spawn_enemy.connect($World._on_game_control_spawn_enemy)
	gamecontrol_node.stop_game.connect(_on_game_control_stop_game)
	gamecontrol_node.stop_game.connect($World._on_game_control_stop_game)
	get_node("World").player_hit.connect(gamecontrol_node._on_world_player_hit)

func anim_splat() -> void:
	var this_splat = splat_node.instantiate()
	this_splat.position = anim_center
	this_splat.z_index = ordering_level
	
	get_node(".").add_child(this_splat)
	print("MAINWINDOW",":Splat")


func _on_game_control_endless_do_splat() -> void:
	anim_splat()

func anim_point() -> void:
	var this_point = point_node.instantiate()
	this_point.position = anim_center
	this_point.z_index = ordering_level
	
	get_node(".").add_child(this_point)
	print("MAINWINDOW",":Point")

func _on_game_control_endless_do_point() -> void:
	anim_point()

func anim_endgame(points: int) -> void:
	var this_endgame = endgame_node.instantiate()
	this_endgame.set_point(points)
	this_endgame.position = anim_center
	this_endgame.z_index = ordering_level - 100
	
	get_node(".").add_child(this_endgame)

func _on_game_control_stop_game(score: int) -> void:
	anim_endgame(score)
	close_enabled = true

func _unhandled_key_input(event: InputEvent) -> void:
	if close_enabled == true:
		if event.is_action_pressed("space"):
			get_tree().paused = false
			var menu_node = load("res://Menu_Window.tscn").instantiate()
			get_tree().get_root().add_child(menu_node)
			queue_free()
