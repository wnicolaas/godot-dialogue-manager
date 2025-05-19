extends Node

var skills := {
	"humor": 5,
	"intelligence": 3,
	"charisma": 8
}

func level_up_skill(skill_id: String) -> void:
	var current_level = skills[skill_id]
	skills[skill_id] = current_level + 1
	
func level_down_skill(skill_id: String) -> void:
	var current_level = skills[skill_id]
	skills[skill_id] = current_level - 1

func get_skill_level(skill_id: String) -> int:
	return skills[skill_id]
