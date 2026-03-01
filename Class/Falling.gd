extends State
var cVelocity
var gravity
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	
	cVelocity = Entity.cVelocity
	
func _physics_update(_delta: float) -> void:
	if !Entity.is_on_floor():
		Entity.velocity.y += Entity.get_gravity().y * _delta
	else:
		Entity.velocity.y = 0
		state_machine.change_state("idle")
	Entity.move_and_slide()
