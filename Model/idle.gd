extends State

func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine)
func update(_delta: float) -> void:
	if IHandler.mov > Vector2(0,0):
		state_machine.change_state("walk")
