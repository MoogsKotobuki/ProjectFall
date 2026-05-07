extends State
var cVelocity

var jumpForce:float
var jumpLimiter :int= 0
@export var maxJump = 2

func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	
	jumpForce = Entity.moveAttributes.jumpForce
	Entity.specialStates = "Standing"
	if Entity.is_on_floor():
		jumpLimiter = 0
	jumpLimiter += 1
	
func _update(_delta: float) -> void:
	pass
func exit()-> void:
	pass
func _physics_update(_delta: float) -> void:
	
	if jumpLimiter > maxJump:
		state_machine.change_state("fall")
	else:
		Entity.velocity.y = jumpForce * 10
		state_machine.change_state("fall")
		Entity.move_and_slide()
