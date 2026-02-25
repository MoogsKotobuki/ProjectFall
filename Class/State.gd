class_name State extends Node

var state_machine: StateMachine
# Called when the node enters the scene tree for the first time.

var Entity:Entity
var IHandler:InputHandler

func enter() -> void:
	pass
func exit()-> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	pass
