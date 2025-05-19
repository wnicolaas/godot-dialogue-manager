extends Node2D

var currentDialogueNode: DialogueNode
var dialogueButtons: Array[Button]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentDialogueNode = ResourceLoader.load("res://dialogues/wietse/root_wietse.tres") as DialogueNode
	draw_ui()

func load_next_node(id: String) -> void:
	currentDialogueNode = ResourceLoader.load("res://dialogues/wietse/" + id + ".tres") as DialogueNode
	draw_ui()

func draw_ui() -> void:
	$Label.text = currentDialogueNode.text
	$"Humor level".text = str(PlayerState.get_skill_level("humor"))
	
	var offset = 0
	for choice in currentDialogueNode.choices:
		var choiceButton = Button.new();
		choiceButton.size.x = 800;
		choiceButton.text = choice.text;
		choiceButton.position.y = 200 + offset;
		
		var fails_condition = false
		for condition in choice.conditions:
			if not condition.is_met():
				fails_condition = true
		
		if fails_condition:
			choiceButton.disabled = true
			choiceButton.text += " [Disabled]"
		
		choiceButton.button_up.connect(func(): handle_dialogue_click(choice))
		
		offset += 50;
		dialogueButtons.append(choiceButton)
		self.add_child(choiceButton)


func handle_dialogue_click(choice: DialogueChoice) -> void:
	for button in dialogueButtons:
		button.queue_free()
	
	for effect in choice.effects:
		effect.apply()
	
	dialogueButtons = []

	load_next_node(choice.next_node_id)
	
