extends VBoxContainer

@onready var ConditionTypeInput = $ConditionTypeInput

func select_condition(condition: DialogueCondition) -> void:
	if condition is SkillCondition:
		ConditionTypeInput.text = "Skill condition"
	else:
		ConditionTypeInput.text = "Unrecognized condition"
