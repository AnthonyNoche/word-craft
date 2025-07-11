extends Control

func _on_new_game_btn_pressed() -> void:
	print("new game")
	get_tree().change_scene_to_file("res://scenes/new_game_screen.tscn")
	#file scene inside teh parenthesis


func _on_continue_btn_pressed() -> void:
	print("continue")
	get_tree().change_scene_to_file("res://scenes/load_game_screen.tscn")
	#file scene inside teh parenthesis


func _on_leaderboards_btn_pressed() -> void:
	print("leaderboards")
	get_tree().change_scene_to_file("res://scenes/leader_borads_screen.tscn")
	#file scene inside teh parenthesis


func _on_settings_btn_pressed() -> void:
	print("settings")
	get_tree().change_scene_to_file("res://scenes/settings_screen.tscn")
	#file scene inside teh parenthesis

	
func _on_about_btn_pressed() -> void:
	print("about")
	get_tree().change_scene_to_file("res://scenes/about_screen.tscn")
	#file scene inside teh parenthesis


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
	
func _on_logo_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/splash_screen_screen.tscn")
