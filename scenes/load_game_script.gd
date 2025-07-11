extends Control


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_screen.tscn")


func _on_load_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/profile_screen.tscn")
