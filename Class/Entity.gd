class_name Entity

extends CharacterBody3D

var cVelocity = 0.0

func _process(delta: float) -> void:
	print("In Floor: " + str(is_on_floor()))
