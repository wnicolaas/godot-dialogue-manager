class_name DialogueCondition extends Resource

# Base class for conditions

func is_met() -> bool:
	return true  # Override in child classes




# For example :
#extends Condition
#class_name HasItemCondition
#
#@export var item_id: String
#
#func is_met(game_state: Node) -> bool:
	#return game_state.player_inventory.has(item_id)
