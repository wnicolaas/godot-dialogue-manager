class_name DialogueChoice extends Resource

@export var text: String
@export var next_node_id: String # Goes back to a node
@export var conditions: Array[DialogueCondition] = [] # Requirements or blocks
@export var effects: Array[DialogueEffect] = [] # Additional effects 
