class_name ReadyState

func Ready(state:State,state_m:StateMachine,model:int)->void:
	
	match model:
		1:
			var r = SReady.new()	
			state.Entity = state_m.get_parent()
			r.GetInputHandler(state.Entity)
			state.IHandler = r.object[0]
