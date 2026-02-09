class_name GetAlgo
var value

func getCharacter3D(node:Node) -> void:
	var parent = node.get_parent()
	
	if parent is not CharacterBody3D:
		parent = parent.get_parent()
	else:
		value = parent

func getInputHandler(node:Node) -> void:
	
	var parent = node
	
	for child in parent.get_children():
		if child.name == "InputHandler":
			value = child
	
	
