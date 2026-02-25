class_name StateMachine extends Node


@export var initial_state: State
var current_state: State
var states:Dictionary[String,State] = {}

var IHandler:InputHandler

func _ready() -> void:
	var parent = get_parent()

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
	print(current_state)
