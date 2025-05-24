class_name SkillCondition extends DialogueCondition

@export var skill_id: String
@export var value: int

func is_met() -> bool:
	return PlayerState.get_skill_level(skill_id) >= value

@warning_ignore("native_method_override") ## Todo remove this, rely on options instead
func get_class() -> String:
	return "SkillCondition"
