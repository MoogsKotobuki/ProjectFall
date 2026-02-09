extends State


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine)
func _update(_delta: float) -> void:
	if IHandler.mov == Vector2(0,0):
		state_machine.change_state("Idle")
func _physics_update(_delta: float) -> void:
	Entity.velocity.x = 1 * IHandler.mov.x
	Entity.velocity.z = 1 * IHandler.mov.y
	
	Entity.move_and_slide()
	
