extends Control

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/profile_screen.tscn")


func _on_verb_view_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections/iregular_verbs_scene.tscn")


func _on_morphology_view_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections/affix_screen.tscn")


func _on_vocabulary_view_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections/synonyms_antonyms_screen.tscn")
