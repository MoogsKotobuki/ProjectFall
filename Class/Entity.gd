extends CharacterBody3D
class_name Entity


@export var mass = 2.0
@export var JumpForce:float = 2.0
@export var runSpeed:float = 5.0
@export var walkSpeed:float =1.5

var stateStatus : String
var previousMaxSpeed
var viewSides = 0.0
func _process(delta: float) -> void:
	#print("In Floor: " + str(is_on_floor()))
	DebugVariable.PlayerVelocity = velocity.x

func _physics_process(delta: float) -> void:
	rotation.y = lerp_angle(rotation.y,viewSides,10 * delta)
