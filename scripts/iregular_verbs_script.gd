extends Control

@onready var popup = $DefinitionPopup
@onready var word_label = $DefinitionPopup/VBoxContainer/WordLabel
@onready var definition_label = $DefinitionPopup/VBoxContainer/DefinitionLabel
@onready var close_button = $DefinitionPopup/VBoxContainer/CloseButton
@onready var word_columns = $ScrollContainer/VBoxContainer 

var definitions = {
	"present": "An event that is currently happening.",
	"past": "An event that happened before.",
	"future": "An event that is about to happen.",
	
	#row 1
	"eat": "The base form of the verb, meaning to consume food.",
	"ate": "The past tense of 'eat,' used to describe food consumed in the past.",
	"will eat": "The future tense of 'eat,' used to describe food that someone is going to consume.",
	
	# row 2
	"go": "The base form of the verb, meaning to move from one place to another.",
	"went": "The past tense of 'go,' used to describe movement that already happened.",
	"will go": "The future tense of 'go,' indicating someone is going to move or travel.",
	
	# row 3
	"take": "The base form of the verb, meaning to carry or bring something.",
	"took": "The past tense of 'take,' used to describe when something was carried or taken.",
	"will take": "The future tense of 'take,' indicating something is going to be carried or picked up.",

	# row 4
	"see": "The base form of the verb, meaning to use one’s eyes to look at something.",
	"saw": "The past tense of 'see,' describing something that was seen.",
	"will see": "The future tense of 'see,' indicating something that someone is going to look at.",

	# row 5
	"write": "The base form of the verb, meaning to form letters or words on a surface.",
	"wrote": "The past tense of 'write,' used to describe something already written.",
	"will write": "The future tense of 'write,' indicating something that will be written.",

	# row 6
	"give": "The base form of the verb, meaning to offer something to someone.",
	"gave": "The past tense of 'give,' used when something was already offered or handed over.",
	"will give": "The future tense of 'give,' indicating something is going to be offered.",

	# row 7
	"begin": "The base form of the verb, meaning to start something.",
	"began": "The past tense of 'begin,' used to describe when something already started.",
	"will begin": "The future tense of 'begin,' indicating the start of something yet to happen.",

	# row 8
	"drink": "The base form of the verb, meaning to consume liquid.",
	"drank": "The past tense of 'drink,' used to describe liquid already consumed.",
	"will drink": "The future tense of 'drink,' indicating someone will consume a liquid.",

	# row 9
	"sing": "The base form of the verb, meaning to produce musical sounds with the voice.",
	"sang": "The past tense of 'sing,' used to describe singing that already happened.",
	"will sing": "The future tense of 'sing,' indicating singing that will happen.",

	# row 10
	"run": "The base form of the verb, meaning to move quickly on foot.",
	"ran": "The past tense of 'run,' used to describe quick movement that already happened.",
	"will run": "The future tense of 'run,' indicating someone is going to move quickly.",

	# row 11
	"fly": "The base form of the verb, meaning to move through the air.",
	"flew": "The past tense of 'fly,' used to describe flight that already occurred.",
	"will fly": "The future tense of 'fly,' indicating future air travel or movement.",

	# row 12
	"drive": "The base form of the verb, meaning to operate a vehicle.",
	"drove": "The past tense of 'drive,' used to describe operating a vehicle in the past.",
	"will drive": "The future tense of 'drive,' indicating vehicle operation that will happen.",

	# row 13
	"come": "The base form of the verb, meaning to move toward the speaker or a place.",
	"came": "The past tense of 'come,' used to describe someone who already arrived.",
	"will come": "The future tense of 'come,' indicating someone is going to arrive.",

	# row 14
	"ride": "The base form of the verb, meaning to sit on and control a vehicle or animal.",
	"rode": "The past tense of 'ride,' used to describe when someone already rode something.",
	"will ride": "The future tense of 'ride,' indicating someone is going to ride.",

	# row 15
	"fall": "The base form of the verb, meaning to drop down from a higher place.",
	"fell": "The past tense of 'fall,' describing when something or someone already dropped.",
	"will fall": "The future tense of 'fall,' indicating something is going to drop.",

	# row 16
	"blow": "The base form of the verb, meaning to move air or cause wind.",
	"blew": "The past tense of 'blow,' used to describe when air already moved.",
	"will blow": "The future tense of 'blow,' indicating wind or air movement to come.",

	# row 17
	"choose": "The base form of the verb, meaning to pick or select.",
	"chose": "The past tense of 'choose,' used when a decision or selection was made.",
	"will choose": "The future tense of 'choose,' indicating a selection that will be made.",

	# row 18
	"break": "The base form of the verb, meaning to separate into pieces or damage.",
	"broke": "The past tense of 'break,' describing something that was damaged.",
	"will break": "The future tense of 'break,' indicating something is going to be damaged.",

	# row 19
	"swim": "The base form of the verb, meaning to move through water.",
	"swam": "The past tense of 'swim,' used when someone already moved in water.",
	"will swim": "The future tense of 'swim,' indicating water movement that will happen.",

	# row 20
	"grow": "The base form of the verb, meaning to increase in size or develop.",
	"grew": "The past tense of 'grow,' describing something that already developed.",
	"will grow": "The future tense of 'grow,' indicating something will develop or increase.",

	# row 21
	"hide": "The base form of the verb, meaning to conceal or keep out of sight.",
	"hid": "The past tense of 'hide,' used to describe something that was hidden.",
	"will hide": "The future tense of 'hide,' indicating concealment that will happen.",

	# row 26
	"think": "The base form of the verb, meaning to have an idea or form an opinion.",
	"thought": "The past tense of 'think,' used when someone already had an idea or belief.",
	"will think": "The future tense of 'think,' indicating someone will form an idea or opinion.",


	# row 23
	"wear": "The base form of the verb, meaning to have clothes or accessories on.",
	"wore": "The past tense of 'wear,' describing what someone had on before.",
	"will wear": "The future tense of 'wear,' indicating clothing or accessories to be used.",

	# row 24
	"speak": "The base form of the verb, meaning to say words aloud.",
	"spoke": "The past tense of 'speak,' used when someone already said something.",
	"will speak": "The future tense of 'speak,' indicating words to be said later.",

	# row 25
	"catch": "The base form of the verb, meaning to grab or seize something in motion.",
	"caught": "The past tense of 'catch,' used when something was already grabbed or seized.",
	"will catch": "The future tense of 'catch,' indicating something will be grabbed or seized.",

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
	get_tree().change_scene_to_file("res://scenes/continue/collections/regular_verbs_screen.tscn")


func _on_right_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections/regular_verbs_screen.tscn")
