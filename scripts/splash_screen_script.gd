extends Control

@export var load_scren : PackedScene
@export var in_time : float = 0.5
@export var fade_in_time : float  = 1
@export var pause_time : float  = 1.5 
@export var fade_out_time : float  = 1
@export var out_time : float  = 1.5 
@onready var splash_screen : TextureRect = $TextureRect

var fade_started : bool = false

func fade() -> void:
	if fade_started:
		return
	fade_started = true
	
	if not splash_screen:
		push_error("splash_screen is null! Check the node path.")
		return
		
	splash_screen.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_screen, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_screen, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/main_menu_screen.tscn")

func _ready() -> void:
	fade()
