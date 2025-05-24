class_name NodeChoiceEditor extends VBoxContainer

@onready var ChoiceTextInput = $ChoiceTextInput
@onready var NextNodeIdInput = $NextNodeIdInput
@onready var ConditionEditor = $ConditionEffectTabs/Conditions/ConditionEditor
@onready var ConditionSelectorContainer = $ConditionEffectTabs/Conditions/ConditionSelectorContainer
@onready var AddConditionButton = $ConditionEffectTabs/Conditions/ConditionSelectorContainer/AddConditionButton

func load_choice(choice: DialogueChoice) -> void:
	ChoiceTextInput.text = choice.text
	NextNodeIdInput.text = choice.next_node_id
	
	for index in range(choice.conditions.size()):
		var condition_button = Button.new()
		condition_button.text = "Condition " + str(index + 1)
		condition_button.pressed.connect(ConditionEditor.select_condition.bind(choice.conditions[index]))
		ConditionSelectorContainer.add_child(condition_button)

	ConditionSelectorContainer.move_child(AddConditionButton, choice.conditions.size())
