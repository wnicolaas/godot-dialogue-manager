extends Node2D

var dialogue_root_path = "user://dialogues"

@onready
var DialogueGroupSelectionVbox = $HUD/DialogueGroupVbox/ScrollContainer/DialogueGroupSelectorVbox;

@onready
var DialogueNameField = $HUD/DialogueGroupVbox/DialogueGroupControlsHbox/DialogueGroupNameField

@onready
var NodeSelectionVbox = $HUD/NodeSelectionContainer/NodeSelectionVbox

@onready
var NoNodesDisplay = $HUD/NodeSelectionContainer/NodeSelectionVbox/NoNodes



enum ContentType {
	FILE,
	DIRECTORY
}

var selected_dialog_file_path: String = ""
var selected_dialog_node: DialogueNode = null

func _ready() -> void:
	reset_dialogue_group_options()

func reset_dialogue_group_options() -> void:
	for child in DialogueGroupSelectionVbox.get_children():
		child.queue_free()
	
	var directory_names = list_directory_contents(dialogue_root_path, ContentType.DIRECTORY)
	
	for directory in directory_names:
		var dialogueGroupButton = Button.new()
		dialogueGroupButton.text = directory
		dialogueGroupButton.pressed.connect(_on_dialogue_group_button_pressed.bind(dialogueGroupButton, directory))
		DialogueGroupSelectionVbox.add_child(dialogueGroupButton)	


# Lists either files or directories within a directory (not recursive)
func list_directory_contents(path: String, contentType: ContentType) -> Array:
	var dir := DirAccess.open(path)
	if dir == null:
		return []

	var results := []
	dir.list_dir_begin()
	var content_name = dir.get_next()
	while content_name != "":
		if dir.current_is_dir() and contentType == ContentType.DIRECTORY:
			results.append(content_name)
		
		if not dir.current_is_dir() and contentType == ContentType.FILE:
			results.append(content_name)

		content_name = dir.get_next()
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

func _on_dialogue_group_button_pressed(button: Button, dialogue_folder_name: String) -> void:
	for child in NodeSelectionVbox.get_children():
		if child is Button:
			child.queue_free()
			
	for child in DialogueGroupSelectionVbox.get_children():
		if child is Button:
			child.remove_theme_stylebox_override("normal")
			child.remove_theme_stylebox_override("hover")
			
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.384, 0.259, 0.451)
	var hover_style = StyleBoxFlat.new()
	style.bg_color = Color(0.303, 0.199, 0.358)
	button.add_theme_stylebox_override("normal", style)
	button.add_theme_stylebox_override("hover", hover_style)
			
	var node_path_prefix = "/" + dialogue_folder_name
	
	$HUD/NodeEditor.toggle_display()
	
	var resourceNames = list_directory_contents(
		dialogue_root_path + "/" + node_path_prefix,
		ContentType.FILE)

	if resourceNames.is_empty():
		NoNodesDisplay.visible = true
		return

	NoNodesDisplay.visible = false

	for resource in resourceNames:
		var nodeButton = Button.new()
		nodeButton.text = resource
		nodeButton.pressed.connect(_on_node_button_pressed.bind(node_path_prefix + "/" + resource))
		NodeSelectionVbox.add_child(nodeButton)
	
	
func _on_node_button_pressed(node_path):
	$HUD/NodeEditor.load_node(dialogue_root_path + node_path)
