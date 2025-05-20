extends Node2D

var dialogue_path = "res://dialogues"

@onready
var DialogueSelector = $HUD/VBoxContainer/DialogueSelector;

func _ready() -> void:
	refresh_ui()

func refresh_ui() -> void:
	DialogueSelector.clear()
	var directory_names = list_directories(dialogue_path)
	
	for directory in directory_names:
		DialogueSelector.add_item(directory)
	
	DialogueSelector.select(-1)

func list_directories(path: String) -> Array:
	var dir := DirAccess.open(path)
	if dir == null:
		return []

	var directories := []
	dir.list_dir_begin()
	var name = dir.get_next()
	while name != "":
		if dir.current_is_dir():
			directories.append(name)
		name = dir.get_next()
	dir.list_dir_end()

	return directories

func _on_add_dialogue_button_pressed() -> void:
	var dir := DirAccess.open(dialogue_path)
	if dir == null:
		return

	# todo: add validation
	var new_dialogue_name = $HUD/VBoxContainer/DialogueName.text
	dir.make_dir(new_dialogue_name)

	refresh_ui()
