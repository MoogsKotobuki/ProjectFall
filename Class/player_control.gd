extends StateControl

@export var sm:StateMachine
@export var ent:Entity

var delayTimer:Timer

func _ready() -> void:
	pass

func _update(_delta: float) -> void:
	var input = Input.get_vector("mvLeft","mvRight","mvUp","mvDown")
	state_machine.mov = input
	
	if sm.current_state.name == "dead":
		return
	dash()
	match (sm.current_state.name.to_lower()):
		
		"idle":
			jump()
			if abs(input.x) > 0.5:
				sm.change_state("run") 
				return
			if abs(input.x) > 0.2:
				sm.change_state("walk")
			if input.y > 0.2:
				sm.change_state("duck")
		"walk":
			jump()
			if abs(input.x) > 0.5:
				sm.change_state("run")
			if input.y > 0.2:
				sm.change_state("duck")
		"run":
			jump()
			if input.y > 0.2:
				sm.change_state("duck")
		"duck":
			if abs(input.x) > 0.2:
				sm.change_state("duckwalk")
			
		"fall":
			jump()
			
			if ent.is_on_floor():
				if abs(input.x) <= 0:
					sm.change_state("idle")
					return
				if input.y>0.2:
					sm.change_state("duck")
					return
				if abs(input.x) > 0.5:
					sm.change_state("run") 
					return
				if abs(input.x) > 0.2:
					sm.change_state("walk")
			
		
func jump()->void:
	if Input.is_action_just_pressed("jump"):
		sm.change_state("jump")

func dash()->void:
	if Input.is_action_just_pressed("Dash"):
		sm.change_state("dash")
