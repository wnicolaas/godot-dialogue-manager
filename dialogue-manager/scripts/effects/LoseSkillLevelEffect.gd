class_name LoseSkillLevelEffect extends DialogueEffect

@export var skill_id: String

func apply() -> void:
	PlayerState.level_down_skill(skill_id)
