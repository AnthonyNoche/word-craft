extends Control

func _on_back_button_pressed() -> void:
	print("back")
	get_tree().change_scene_to_file("res://scenes/main_menu_screen.tscn")
	

var characters = [
	{
		"name": "Noah",
		"texture": preload("res://images/noah.png") 
	},
	{
		"name": "Naomi",
		"texture": preload("res://images/naomi.png") 
	}
]
	
var current_index = 0

@onready var character_display = $CharacterDisplay
@onready var character_name = $CharacterName

func _ready():
	update_character()

func update_character():
	var char_data = characters[current_index]
	character_display.texture = char_data["texture"]
	character_name.text = char_data["name"]

func _on_LeftButton_pressed():
	current_index = (current_index - 1 + characters.size()) % characters.size()
	update_character()

func _on_RightButton_pressed():
	current_index = (current_index + 1) % characters.size()
	update_character()

func _on_SelectButton_pressed():
	print("Selected: ", characters[current_index]["name"])


func _on_select_button_pressed() -> void:
	var selected_name = characters[current_index]["name"]
	GlobalData.selected_character_name = selected_name
	get_tree().change_scene_to_file("res://scenes/user_name.tscn")


func _on_right_button_pressed() -> void:
	pass # Replace with function body.


func _on_left_button_pressed() -> void:
	pass # Replace with function body.
