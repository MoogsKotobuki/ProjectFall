extends Node3D
class_name CharacterModel

@export var modelName = name
@onready var parent:Entity = get_parent()
@onready var animTree:AnimationTree = get_node("AnimationTree")
func _ready() -> void:
	animTree.active = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animTree.set("parameters/On Air/blend_position",parent.velocity.y)
