extends StateControl

func _update(_delta: float) -> void:
	var input = Input.get_vector("mvLeft","mvRight","mvUp","mvDown")
	state_machine.mov = input
	
