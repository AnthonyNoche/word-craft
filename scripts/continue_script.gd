extends Control


func _on_lesson_video_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/lesson_video_screen.tscn")


func _on_collection_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections_screen.tscn")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_screen.tscn")
