extends Node2D

const aboutbox_node = preload("res://UI/aboutbox.tscn")
const aboutbox_loc = Vector2(471, 97)

const mainwindow_node = preload("res://mainWindow.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_game(gamecontrolfile: Resource) -> void:
	var this_mainwindow = mainwindow_node.instantiate()
	this_mainwindow.bind_gamecontrol(gamecontrolfile)
	get_tree().get_root().add_child(this_mainwindow)
	queue_free()
	
func _on_button_pressed() -> void:
	load_game(load("res://procedures/game_control_endless.tscn"))
	
func _on_button_2_pressed() -> void:
	load_game(load("res://procedures/game_control_endless_3_lives.tscn"))

func _on_button_about_pressed() -> void:
	# Spawn object
	var aboutbox_this = aboutbox_node.instantiate()
	aboutbox_this.position = aboutbox_loc
	aboutbox_this.z_index = 3000
	get_node(".").add_child(aboutbox_this)
	
	# Temppause
