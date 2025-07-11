extends Control

@onready var popup = $DefinitionPopup
@onready var word_label = $DefinitionPopup/VBoxContainer/WordLabel
@onready var definition_label = $DefinitionPopup/VBoxContainer/DefinitionLabel
@onready var close_button = $DefinitionPopup/VBoxContainer/CloseButton
@onready var word_columns = $bg/ScrollContainer/VBoxContainer 

var definitions = {
	"present": "An event that is currently happening.",
	"past": "An event that happened before.",
	"future": "An event that is about to happen.",
	
	# row 1
	"walking": "The base form of the verb 'walk,' used for present tense and general action.",
	"walked": "The past tense of 'walk,' used to describe someone who has already walked.",
	"will walk": "Used to indicate future movement from one place to another.",
	
	# row 2
	"visiting": "The present participle of 'visit,' used to describe an ongoing visit.",
	"visited": "The past tense of 'visit,' used to describe a completed visit.",
	"will visit": "Used to describe a future action of going to see someone or someplace.",
	
	# row 3
	"playing": "The present participle of 'play,' used for ongoing games or activities.",
	"played": "The past tense of 'play,' indicating a completed activity or game.",
	"will play": "Used to describe a future action involving a game or performance.",
	
	# row 4
	"cleaning": "The present participle of 'clean,' describing the process of making something clean.",
	"cleaned": "The past tense of 'clean,' indicating that cleaning was done.",
	"will clean": "Used to describe an intention to clean something in the future.",
	
	# row 5
	"baking": "The present participle of 'bake,' referring to the act of cooking in an oven.",
	"baked": "The past tense of 'bake,' showing that something has already been cooked.",
	"will bake": "Used to express a future action of cooking in the oven.",
	
	# row 6
	"calling": "The present participle of 'call,' used when someone is in the process of phoning or shouting.",
	"called": "The past tense of 'call,' indicating someone already made a phone call or shouted.",
	"will call": "Used to express that someone plans to make a call in the future.",
	
	# row 7
	"jumping": "The present participle of 'jump,' describing a movement upward off the ground.",
	"jumped": "The past tense of 'jump,' used to describe someone who has already jumped.",
	"will jump": "Used to indicate a person will jump in the future.",
	
	# row 8
	"watching": "The present participle of 'watch,' used when observing something attentively.",
	"watched": "The past tense of 'watch,' meaning the act of watching has already happened.",
	"will watch": "Used to state that someone intends to watch something in the future.", 
	
	# row 9
	"opening": "The present participle of 'open,' describing the act of making something not closed.",
	"opened": "The past tense of 'open,' showing the action was completed.",
	"will open": "Used to describe a future intention to make something open.",
	
	# row 10
	"talking": "The present participle of 'talk,' describing someone who is speaking.",
	"talked": "The past tense of 'talk,' indicating that speaking already happened.",
	"will talk": "Used to express that someone will speak in the future.",
	
	# row 11
	"listening": "The present participle of 'listen,' referring to the act of actively hearing something.",
	"listened": "The past tense of 'listen,' indicating the act of listening has occurred.",
	"will listen": "Used to express that someone will listen in the future.",

	# row 12
	"climbing": "The present participle of 'climb,' referring to the act of going up something.",
	"climbed": "The past tense of 'climb,' showing the action has already been done.",
	"will climb": "Used to describe a future action of ascending something.",

	# row 13
	"helping": "The present participle of 'help,' showing someone is giving assistance.",
	"helped": "The past tense of 'help,' indicating that help was given.",
	"will help": "Used to describe an intention to assist in the future.",

	# row 14
	"brushing": "The present participle of 'brush,' referring to cleaning or grooming with a brush.",
	"brushed": "The past tense of 'brush,' indicating the action is completed.",
	"will brush": "Used to state a future act of brushing.",

	# row 15
	"starting": "The present participle of 'start,' meaning something is beginning.",
	"started": "The past tense of 'start,' indicating something has already begun.",
	"will start": "Used to express that something will begin in the future.",

	# row 16
	"pushing": "The present participle of 'push,' referring to applying force to move something away.",
	"pushed": "The past tense of 'push,' showing the action has already been done.",
		"will push": "Used to describe a future act of applying force.",
		
		# row 17
	"painting": "The present participle of 'paint,' referring to applying color to a surface.",
	"painted": "The past tense of 'paint,' indicating the painting is already done.",
	"will paint": "Used to describe a future action of applying paint.",

	# row 18
	"laughing": "The present participle of 'laugh,' used when someone is expressing amusement.",
	"laughed": "The past tense of 'laugh,' showing someone already laughed.",
	"will laugh": "Used to indicate someone will laugh in the future.",

	# row 19
	"counting": "The present participle of 'count,' referring to the act of numbering things.",
	"counted": "The past tense of 'count,' indicating the act of counting has been completed.",
	"will count": "Used to describe a future action of numbering or calculating items.",


	# row 20
	"pulling": "The present participle of 'pull,' meaning drawing something toward oneself.",
	"pulled": "The past tense of 'pull,' indicating the action has already occurred.",
	"will pull": "Used to describe a future act of pulling something.",

	# row 21
	"fixing": "The present participle of 'fix,' referring to repairing or correcting something.",
	"fixed": "The past tense of 'fix,' meaning the repair or correction has been completed.",
	"will fix": "Used to state that someone will repair or correct something later.",

	# row 22
	"planting": "The present participle of 'plant,' referring to putting seeds or plants into soil.",
	"planted": "The past tense of 'plant,' indicating that the planting has been completed.",
	"will plant": "Used to express a future action of putting plants in the ground.",

	# row 23
	"shouting": "The present participle of 'shout,' used when someone is yelling loudly.",
	"shouted": "The past tense of 'shout,' indicating someone has already yelled.",
	"will shout": "Used to describe someone yelling in the future.",

	# row 24
	"borrowing": "The present participle of 'borrow,' referring to taking something temporarily.",
	"borrowed": "The past tense of 'borrow,' showing something was borrowed.",
	"will borrow": "Used to indicate an action of borrowing in the future.",

	# row 25
	"closing": "The present participle of 'close,' meaning to shut something.",
	"closed": "The past tense of 'close,' indicating that something has already been shut.",
	"will close": "Used to express that something will be shut in the future.",

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
	get_tree().change_scene_to_file("res://scenes/continue/collections/iregular_verbs_scene.tscn")

func _on_right_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/continue/collections/iregular_verbs_scene.tscn")
