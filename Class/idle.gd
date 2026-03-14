extends State
@export var decel = 10
@export var friction = 1

func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	Entity.previousMaxSpeed = Entity.runSpeed
func _update(_delta: float) -> void:	
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jump")
	
	if !Entity.is_on_floor():
		state_machine.change_state("fall")
	
	if input_strenght >0.1:
		state_machine.change_state("walk")
		
	if input_strenght >0.75:
		state_machine.change_state("run")
	
	if Entity.is_on_floor() and Input.is_action_pressed("jump"):
		state_machine.change_state("jump")
func _physics_update(_delta: float) -> void:
	if Entity.velocity.x != 0 :
		if Entity.velocity.x > 0:
			Entity.velocity.x -= decel * _delta
			Entity.velocity.x = clamp(Entity.velocity.x,0,99)
		if Entity.velocity.x < 0:
			Entity.velocity.x += decel * _delta
			Entity.velocity.x = clamp(Entity.velocity.x,-99,0)
		
	Entity.move_and_slide()
