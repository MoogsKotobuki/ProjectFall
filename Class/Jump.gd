extends State
var cVelocity

var jumpLimit :int= 0
@export var maxJump = 2
@onready var timer = $Timer

func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
		
func _update(_delta: float) -> void:
	if Input.is_action_pressed("jump"):
		jumpLimit += 1
		print(jumpLimit)
func exit()-> void:
	pass
func _physics_update(_delta: float) -> void:
	if jumpLimit < maxJump:
		Entity.velocity.y = Entity.JumpForce * 10
	if timer.is_stopped():
		state_machine.change_state("fall")
	Entity.move_and_slide()
