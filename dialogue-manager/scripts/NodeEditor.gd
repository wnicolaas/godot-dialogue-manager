class_name NodeEditor extends VBoxContainer


### Dialogue node editor ###
@onready var DialogueNodeIdInput = $Vbox/NodeIdInput
@onready var ActorIdInput = $Vbox/ActorIdInput
@onready var DialogueNodeTextEditor = $Vbox/NodeTextEdit
@onready var NodeChoiceContainer = $Vbox/NodeChoiceContainer

## Visibility
@onready var NoGroupDisplay = $NoGroupSelected
@onready var DialogueNodeWindow = $Vbox

var NodeChoiceEditorScene = preload("res://scenes/NodeChoiceEditor.tscn")

var selected_dialogue_file_path: String = ""
var selected_dialogue_node: DialogueNode = null

func load_node(node_path: String) -> void:
	self.selected_dialogue_file_path = node_path
	self.selected_dialogue_node = load(node_path) as DialogueNode
	
	DialogueNodeIdInput.text = self.selected_dialogue_node.id
	ActorIdInput.text = self.selected_dialogue_node.actor_id
	DialogueNodeTextEditor.text = self.selected_dialogue_node.text
	
	
	for child in NodeChoiceContainer.get_children():
		child.free()
	
	for index in range(selected_dialogue_node.choices.size()):
		var choice_editor = NodeChoiceEditorScene.instantiate()
		NodeChoiceContainer.add_child(choice_editor)
		choice_editor.name = "Choice " + str(index + 1)
		choice_editor.load_choice(selected_dialogue_node.choices[index])

func _on_save_pressed() -> void:
	self.selected_dialogue_node.id = DialogueNodeIdInput.text 
	self.selected_dialogue_node.actor_id = ActorIdInput.text
	self.selected_dialogue_node.text = DialogueNodeTextEditor.text

	ensure_user_folders_exist(selected_dialogue_file_path)
	var error = ResourceSaver.save(selected_dialogue_node, selected_dialogue_file_path)
	
	if error:
		push_error(error)
		
# As the resource saver cannot create folders, this creates any missing folders from a save path
func ensure_user_folders_exist(path: String):
	var dir = DirAccess.open("user://")
	if not dir:
		push_error("No access to user directory")
		return

	var parts = path.replace("user://", "").split("/")
	parts.remove_at(parts.size() - 1)  # Remove the file itself, we only need the directories
	var current_path = "user://"

	for folder in parts:
		current_path += folder + "/"
		if not DirAccess.dir_exists_absolute(current_path):
			var err = DirAccess.make_dir_absolute(current_path)
			if err != OK:
				push_error("Failed to create folder: %s (error %d)" % [current_path, err])
				
func toggle_display(visible = true) -> void:
	DialogueNodeWindow.visible = visible
	NoGroupDisplay.visible = !visible
