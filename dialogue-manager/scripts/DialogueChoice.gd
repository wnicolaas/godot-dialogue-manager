class_name DialogueChoice extends Resource

@export var text: String
@export var next_node_id: String # Goes back to a node
@export var conditions: Array[DialogueCondition] = [] # Requirements or blocks
@export var effects: Array[DialogueEffect] = [] # Additional effects 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
