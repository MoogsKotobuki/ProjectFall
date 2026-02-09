class_name ReadyState

func Ready(state:State,state_m:StateMachine)->void:
	var r = SReady.new()	
	r.Entity(state_m)
	state.Entity = r.object[0]
	r.Handler(state.Entity)
	state.IHandler = r.object[1]
	
