extends State
@export var decel = 10
@export var friction = 1

func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
func _update(_delta: float) -> void:	
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jump")
	
	
	if input_strenght >0.1:
		state_machine.change_state("walk")
		
	if input_strenght >0.75:
		state_machine.change_state("run")
	
	if Entity.is_on_floor() and Input.is_action_pressed("jump"):
		state_machine.change_state("jump")

func _physics_update(_delta: float) -> void:
	if Entity.cVelocity:
		decelerate(_delta)
	Entity.move_and_slide()
	DebugVariable.PlayerVelocity = Entity.velocity.x


func decelerate(_delta):
	Entity.cVelocity -= decel * _delta
	var basis =  -Entity.global_basis.x
	Entity.cVelocity = clamp(Entity.cVelocity,0,100)
	Entity.velocity.x = Entity.cVelocity * basis.x
	Entity.velocity.x = round(Entity.velocity.x * 100) / 100.0
	
