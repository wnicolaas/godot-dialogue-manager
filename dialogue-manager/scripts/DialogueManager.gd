extends Node2D

var dialogue_root_path = "res://dialogues"

@onready
var DialogueGroupSelectionVbox = $HUD/DialogueGroupVbox/ScrollContainer/DialogueGroupSelectorVbox;

@onready
var DialogueNameField = $HUD/DialogueGroupVbox/DialogueGroupControlsHbox/DialogueGroupNameField

@onready
var ScriptSelectionVbox = $HUD/ScrollContainer/ScriptSelectionVbox

enum ContentType {
	FILE,
	DIRECTORY
}

func _ready() -> void:
	reset_dialogue_group_options()

func reset_dialogue_group_options() -> void:
	for child in DialogueGroupSelectionVbox.get_children():
		child.queue_free()
	
	var directory_names = list_directory_contents(dialogue_root_path, ContentType.DIRECTORY)
	
	for directory in directory_names:
		var dialogueGroupButton = Button.new()
		dialogueGroupButton.text = directory
		dialogueGroupButton.pressed.connect(_on_dialogue_group_button_pressed.bind(directory))
		DialogueGroupSelectionVbox.add_child(dialogueGroupButton)	


# Lists either files or directories within a directory (not recursive)
func list_directory_contents(path: String, contentType: ContentType) -> Array:
	var dir := DirAccess.open(path)
	if dir == null:
		return []

	var results := []
	dir.list_dir_begin()
	var name = dir.get_next()
	while name != "":
		if dir.current_is_dir() and contentType == ContentType.DIRECTORY:
			results.append(name)
		
		if not dir.current_is_dir() and contentType == ContentType.FILE:
			results.append(name)

		name = dir.get_next()
	dir.list_dir_end()

	return results

func _on_add_dialogue_group_button_pressed() -> void:
	var dir := DirAccess.open(dialogue_root_path)
	if dir == null:
		return

	# todo: add validation
	var new_dialogue_name = DialogueNameField.text
	dir.make_dir(new_dialogue_name)

	reset_dialogue_group_options()

func _on_dialogue_group_button_pressed(dialogue_folder_name: String) -> void:
	for child in ScriptSelectionVbox.get_children():
		child.queue_free()
	
	var resourceNames = list_directory_contents(
		dialogue_root_path + "/" + dialogue_folder_name,
		ContentType.FILE)
		
	for resource in resourceNames:
		var scriptButton = Button.new()
		scriptButton.text = resource
		ScriptSelectionVbox.add_child(scriptButton)
	
	
