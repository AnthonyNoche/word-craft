extends Control

var db: SQLite
@onready var line_edit = $TextureRect/Panel/userName
@onready var error_label = $TextureRect/Panel/error_label
@onready var submit_button = $TextureRect/Panel/SubmitButton
@onready var back_button = $TextureRect/Panel/BackButton

var db_ref: FirebaseDatabaseReference
var firebase_ready = false
var timeout_timer: Timer = null

func _ready():
	# Initialize SQLite
	db = SQLite.new()
	db.path = "user://users.db"
	print("Attempting to open database at:", db.path)

	if not db.open_db():
		push_error("SQLite database error - cannot open database")
		print("Database open failed. Check if SQLite plugin is properly installed.")
		return

	print("Database opened successfully")

	# Wait for Firebase Auth to be ready
	await Firebase.Auth.auth_ready
	firebase_ready = true
	print("Firebase initialized:", firebase_ready)

	db_ref = Firebase.Database.get_database_reference("players")
	if db_ref == null:
		print("Firebase database reference is null!")
	else:
		db_ref.new_data_update.connect(_on_firebase_data_updated)

	# Create table if it doesn't exist
	var table = {
		"id": {
			"data_type": "INTEGER",
			"primary_key": true,
			"not_null": true,
			"auto_increment": true
		},
		"userName": {
			"data_type": "TEXT",
			"not_null": true,
			"unique": true
		},
		"character": {
			"data_type": "TEXT",
			"not_null": true
		}
	}

	if not db.table_exists("Player_userNames"):
		var table_created = db.create_table("Player_userNames", table)
		print("Table creation status:", table_created)
		if not table_created:
			print("Table creation failed. Error:", db.query_result)
			return
	else:
		print("Table 'Player_userNames' already exists.")

	# Connect UI signals
	line_edit.text_changed.connect(_on_line_edit_text_changed)
	submit_button.pressed.connect(_on_submit_pressed)
	back_button.pressed.connect(_on_back_button_pressed)


func _on_line_edit_text_changed(new_text: String):
	error_label.text = ""


func _on_submit_pressed() -> void:
	var username = line_edit.text.strip_edges()
	if username.is_empty():
		error_label.text = "Please enter a username!"
		return

	if not is_valid_username(username):
		error_label.text = "Username contains invalid characters!"
		return

	print("Checking if username exists:", username)
	if username_exists(username):
		error_label.text = "Username already exists!"
		return

	var selected_character = GlobalData.selected_character_name
	if selected_character == null or selected_character.is_empty():
		error_label.text = "No character selected!"
		return

	var player_data = {
		"userName": username,
		"character": selected_character
	}

	print("Attempting to insert row:", player_data)
	db.query("BEGIN TRANSACTION;")
	var insert_success = db.insert_row("Player_userNames", player_data)

	if insert_success:
		db.query("COMMIT;")
		print("Insert successful!")

		if firebase_ready:
			print("Firebase is ready, proceeding with upload...")
			save_to_firebase(username, player_data)
		else:
			print("Firebase is not ready! Skipping Firebase upload.")
			error_label.text = "Saved locally but Firebase unavailable."

		line_edit.text = ""
	else:
		db.query("ROLLBACK;")
		print("Insert failed! Error:", db.query_result)
		error_label.text = "Failed to save user data locally: " + str(db.query_result)


func is_valid_username(username: String) -> bool:
	if username.length() < 3 or username.length() > 20:
		return false

	var regex = RegEx.new()
	regex.compile("^[a-zA-Z0-9_-]+$")
	return regex.search(username) != null


func username_exists(username: String) -> bool:
	if db == null:
		print("Database is null!")
		return false

	var result = db.select_rows("Player_userNames", "userName = ?", [username])
	if result == null:
		return false

	return result.size() > 0


func save_to_firebase(username: String, data: Dictionary) -> void:
	print("=== FIREBASE SAVE STARTED ===")

	if db_ref == null:
		error_label.text = "Firebase reference not initialized."
		return

	var safe_key = username
	safe_key = safe_key.replace(".", "_").replace("#", "_").replace("$", "_")
	safe_key = safe_key.replace("[", "_").replace("]", "_")

	var player_ref = db_ref.child(safe_key)

	# Remove any old timeout timers
	if timeout_timer and timeout_timer.is_inside_tree():
		timeout_timer.queue_free()

	timeout_timer = Timer.new()
	timeout_timer.wait_time = 10.0
	timeout_timer.one_shot = true
	timeout_timer.timeout.connect(_on_firebase_timeout)
	add_child(timeout_timer)
	timeout_timer.start()

	player_ref.set(data, _on_firebase_save_complete, _on_firebase_save_failed)


func _on_firebase_timeout():
	print("Firebase upload timed out!")
	error_label.text = "Firebase upload timed out."
	if timeout_timer and timeout_timer.is_inside_tree():
		timeout_timer.queue_free()


async func _on_firebase_save_complete(response):
	print("Firebase save successful! Response:", response)
	if timeout_timer and timeout_timer.is_inside_tree():
		timeout_timer.queue_free()

	error_label.text = ""

	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/character_selection_screen.tscn")


func _on_firebase_save_failed(error):
	print("Firebase save failed! Error:", error)
	if timeout_timer and timeout_timer.is_inside_tree():
		timeout_timer.queue_free()

	error_label.text = "Could not save to Firebase: " + str(error)


func _on_firebase_data_updated(data):
	print("Firebase data update received:", data)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/new_game_screen.tscn")


func _exit_tree():
	if db:
		db.close_db()
		print("Database connection closed.")
