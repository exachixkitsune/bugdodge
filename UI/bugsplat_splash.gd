extends Node2D


const initial_splat_scale = 0
const initial_text_scale = 0
var target_splat_scale = .75
var target_text_scale = 1

const time_to_full_splat = float(10)
const time_to_full_text = float(10)
const time_to_full_endwiggle = time_to_full_text + 10
const time_until_slide = time_to_full_endwiggle + 5
const fadetime = 120
const time_until_end = time_until_slide + fadetime

const wigglemag = 5
const sliderate = 0.2

var currtime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currtime = float(0)
	$Splat.scale = Vector2(1,1)*initial_splat_scale
	$SplatText.scale = Vector2(1,1)*initial_text_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	currtime += 1
	
	# Splat Animation
	if currtime < time_to_full_splat:
		$Splat.scale = Vector2(1,1)*lerpf(initial_splat_scale,target_splat_scale,currtime/time_to_full_splat)
	elif currtime == time_to_full_splat:
		$Splat.scale = Vector2(1,1)*target_splat_scale
		
	# Test Animation
	if currtime < time_to_full_text:
		$SplatText.scale = Vector2(1,1)*lerpf(initial_text_scale, target_text_scale, currtime/time_to_full_text)
	elif currtime == time_to_full_text:
		$SplatText.scale = Vector2(1,1)*target_text_scale
	elif (currtime) < time_to_full_endwiggle:
		$SplatText.position = Vector2(
			randf_range(-wigglemag, wigglemag),
			randf_range(-wigglemag, wigglemag)
		)
	
	if currtime >= time_until_slide:
		$Splat.position.y += sliderate
		$SplatText.position.y += sliderate
		$".".set_modulate(Color(1,1,1,lerpf(1, 0, (currtime - time_until_slide)/fadetime)))
		
	if currtime >= time_until_end:
		queue_free()
