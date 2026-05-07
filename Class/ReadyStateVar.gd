class_name ReadyState

func Ready(state:State,state_m:StateMachine,model:int)->void:
	
	match model:
		1:
			var r = SReady.new()	
			state.Entity = state_m.get_parent()
			r.GetInputHandler(state.Entity)
			state.IHandler = r.object[0]

func addRay(n:Node,Name:String,Position:Vector3,variable = null,targetPos:Vector3 = Vector3(0,-1,0))->void:
	for child in n.get_children():
		if child is RayCast3D and child.name == Name:
			variable.rayD = child
	
	var r = RayCast3D.new()
	r.name = Name
	r.position = Position
	r.target_position = targetPos
	if variable != null:
		variable.rayD = r
	
	n.add_child(r)

func findState(stateMachine,Name:String,variable)->void:
	for child in stateMachine.get_children():
		if child.name == Name:
			variable = child
