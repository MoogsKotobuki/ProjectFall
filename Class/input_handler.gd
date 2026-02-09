class_name InputHandler
extends Node

@export var initial_state: StateControl
var current_state: StateControl
var states:Dictionary[String,State] = {}

var mov:Vector2
var look:Vector2

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_machine = self
			states[child.name.to_lower()] = child
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func _process(delta: float) -> void:
	if current_state:
		current_state._update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_update(delta)

func change_state(new_state_name: String) -> void:
	var new_state = states.get(new_state_name.to_lower())
	
	assert(new_state, "State not found: " + new_state_name)
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
