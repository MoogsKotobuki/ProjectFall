extends CharacterBody3D
class_name Entity

@export var mass = 2.0

@export var playerAttributes={
	"animationState":"null"
}

@export var moveAttributes={
	"speed":
		{
			"run":5.0,
			"walk":1.5,
			"dash":8.0,
			"sprint":6.5
		},
	"jumpForce":1.5,
	}

var stateStatus : String
var previousMaxSpeed
var viewSides = 0.0
var specialStates:String

func _process(delta: float) -> void:
	global_position.z = 0
	#print("In Floor: " + str(is_on_floor()))
	DebugVariable.PlayerVelocity = velocity.x
	
	if specialStates == "Standing":
		$Standing.disabled = false
		$Duck.disabled = true
	elif specialStates == "Duck":
		$Standing.disabled = true
		$Duck.disabled = false
		

func _physics_process(delta: float) -> void:
	rotation.y = lerp_angle(rotation.y,viewSides,10 * delta)
