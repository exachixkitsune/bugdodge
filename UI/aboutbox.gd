extends Node2D

const spawntime = 20
const target_scale = 1.5

var end_text
var currtime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	end_text = $UIBox/Text.text
	$UIBox/Text.text = ""
	currtime = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currtime < spawntime:
		currtime += 1
		$"UIBox".scale = Vector2(1,1)*lerp(0.0,target_scale,float(currtime)/float(spawntime))
	if currtime == spawntime:
		currtime += 1
		$"UIBox".scale = Vector2(1,1)*target_scale
		$UIBox/Text.text = end_text
		
func _on_button_pressed() -> void:
	queue_free()
