extends Control


func _on_back_button_pressed() -> void:
	print("back")
	get_tree().change_scene_to_file("res://scenes/main_menu_screen.tscn")
