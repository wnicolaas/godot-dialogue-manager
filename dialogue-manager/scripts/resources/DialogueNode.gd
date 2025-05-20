class_name DialogueNode extends Resource

@export var id: String # ID of node
@export var actor_id: String # NPC ID
@export var text: String # What the NPC says
@export var choices: Array[DialogueChoice] = [] # What the player can say



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
