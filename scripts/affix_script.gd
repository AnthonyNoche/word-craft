extends Control


@onready var popup = $DefinitionPopup
@onready var word_label = $DefinitionPopup/VBoxContainer/WordLabel
@onready var definition_label = $DefinitionPopup/VBoxContainer/DefinitionLabel
@onready var close_button = $DefinitionPopup/VBoxContainer/CloseButton
@onready var word_columns = $VBoxContainer 

var definitions = {
	"prefix": "A group of letters added to the beginning of a word to change its meaning.",
	"root word": "The base form of a word, to which prefixes or suffixes can be added.",
	"suffix": "A group of letters added to the end of a word to change its form or meaning.",
	"new word": "A word formed by adding a prefix or suffix to a root word.",
	# row 1
	"trans-": "A prefix meaning 'across,' 'beyond,' or 'through.'",
	"form": "The shape, structure, or arrangement of something.",
	"-able": "A suffix meaning 'capable of' or 'worthy of.'",
	"transformable": "Capable of being changed in form, appearance, or structure."
}


func _ready():
	# Check if all nodes exist before using them
	if not popup:
		print("Error: DefinitionPopup not found")
		return
	if not word_label:
		print("Error: WordLabel not found")
		return
	if not definition_label:
		print("Error: DefinitionLabel not found")
		return
	if not close_button:
		print("Error: CloseButton not found")
		return
	
	close_button.pressed.connect(_on_close_pressed)
	
	# Automatically connect all Buttons inside VBoxContainer -> HBoxContainer
	for column in word_columns.get_children():
		for button in column.get_children():
			if button is Button:
				button.pressed.connect(func(): show_definition(button.text))

func _on_close_pressed():
	popup.hide()

func show_definition(word: String):
	word_label.text = word.capitalize()
	definition_label.text = definitions.get(word.to_lower(), "No definition available.")
	popup.popup_centered()
	
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections_screen.tscn")


func _on_left_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections/prefix_screen.tscn")


func _on_right_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections/prefix_screen.tscn")
