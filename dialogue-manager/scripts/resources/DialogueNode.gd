class_name DialogueNode extends Resource

@export var id: String # ID of node
@export var actor_id: String # NPC ID
@export var text: String # What the NPC says
@export var choices: Array[DialogueChoice] = [] # What the player can say
