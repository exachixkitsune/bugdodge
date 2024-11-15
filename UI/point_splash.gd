extends Node2D

const initial_text_scale = .50
var target_text_scale = 1

const time_to_full_text = 10
const wait_time = 60
const time_to_start_fade = time_to_full_text + wait_time
const fade_time = 120
const time_to_fade = time_to_start_fade + fade_time

const wigglemag = 5

var currtime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currtime = float(0)
	$PointText.scale = Vector2(1,1)*initial_text_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	currtime += 1
	
	if currtime <= time_to_full_text:
		$PointText.scale = Vector2(1,1)*lerpf(initial_text_scale, target_text_scale, currtime/time_to_full_text)
		$".".set_modulate(Color(1,1,1,lerpf(0, 1, (currtime/time_to_full_text))))
		
	if currtime >= time_to_start_fade:
		$".".set_modulate(Color(1,1,1,lerpf(1, 0, (currtime - time_to_start_fade)/fade_time)))
	
	if currtime >= time_to_fade:
		queue_free()
