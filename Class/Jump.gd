extends State
var cVelocity

@export var maxJumpForce :float= 10
@export var limit :float= 2

var jump = 0.0

@onready var timer = 0.0

func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	
	cVelocity = Entity.cVelocity

func _update(_delta: float) -> void:
	if Input.is_action_pressed("jump"):
		timer += 1 * _delta
		jump = maxJumpForce * timer
	elif jump > maxJumpForce:
		jump = maxJumpForce
		
func exit()-> void:
	jump = 0.0
	timer = 0.0
func _physics_update(_delta: float) -> void:
	
	if Entity.velocity.y == 0:
		Entity.velocity.y = jump
	else:
		state_machine.change_state("fall")
	Entity.move_and_slide()
