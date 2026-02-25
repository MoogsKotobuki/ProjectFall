extends State

@export var Speed = 1.5
@export var accel = 1
@export var decel = 10
var friction = 1
var cVelocity

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	cVelocity = Entity.cVelocity

func exit() -> void:
	Entity.cVelocity = cVelocity
	
func _update(_delta: float) -> void:
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	
	if input_strenght == 0:
		state_machine.change_state("idle")
	if input_strenght >0.75:
		state_machine.change_state("run")
		
func _physics_update(_delta: float) -> void:
	
	if cVelocity > Speed:
		cVelocity -= (decel * friction) * _delta
	else:
		cVelocity += (accel * Speed) * _delta
		cVelocity = clamp(cVelocity,0,Speed)
	
	var direction = IHandler.mov.x
	print(direction)
	if direction > 0.0001:
		Entity.rotation.y = PI
	elif direction < -0.0001:
		Entity.rotation.y = 0
	var basis =  -Entity.global_basis.x
	Entity.velocity.x = round((cVelocity * basis.x) * 100) / 100.0
	
	DebugVariable.PlayerVelocity = Entity.velocity.x
	
	Entity.move_and_slide()
	
