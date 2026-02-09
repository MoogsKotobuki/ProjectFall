class_name SReady
#this class use for initialize the state machine

var object : Array

func Entity(stateMachine:StateMachine):
	var g = GetAlgo.new()
	
	g.getCharacter3D(stateMachine)
	if g.value != null:
		object.append(g.value)
		g.value == null

func Handler(node:Node):
	var g = GetAlgo.new()
	
	g.getInputHandler(node)
	
	if g.value != null:
		object.append(g.value)
		g.value == null
